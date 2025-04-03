/*  Ecommerce Analysis -
Analyzing Website Performance:
What pages are seen the most by users and to identify where to focus improving business
*/

-- Analyzing landing page test 50/50

-- 1. Finding the first instance of /lander-1 to set analysis timeframe
SELECT 
	MIN(created_at) AS first_created,
	MIN(website_pageview_id) AS first_pageview_id
FROM website_pageviews 
WHERE pageview_url = '/lander-1' AND created_at IS NOT NULL;

-- 2. Finding the first website_pageview_id for revelant sessions
CREATE TEMPORARY TABLE first_test_pageviews
SELECT
	t1.website_session_id,
    MIN(t1.website_pageview_id) AS min_pageview_id
FROM website_pageviews t1
	INNER JOIN website_sessions t2
		ON t1.website_session_id = t2.website_session_id
        AND t2.created_at < '2012-07-28'
        AND t1.website_pageview_id > 23504 -- Min pagview id for lander-1 or use the date '2012-06-19'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY
	t1.website_session_id;

-- 3. Identifying the landing page of each sessssion
CREATE TEMPORARY TABLE test_session_w_lp
SELECT 
	t1.website_session_id,
    t2.pageview_url AS landing_page
FROM first_test_pageviews t1
	LEFT JOIN website_pageviews t2
		ON t2.website_pageview_id = t1.min_pageview_id
WHERE t2.pageview_url IN ('/home', '/lander-1');

-- 4. Counting pageviews for each session, to identify bounces
CREATE TEMPORARY TABLE test_bounced_sessions
SELECT
	t1.website_session_id,
    t1.landing_page,
	COUNT(t2.website_pageview_id) AS count_of_pgs_viewed
FROM test_session_w_lp t1
	LEFT JOIN website_pageviews t2
		ON t2.website_session_id = t1.website_session_id
GROUP BY 
	t1.website_session_id,
    t1.landing_page
HAVING
	COUNT(t2.website_pageview_id) = 1;


-- 5. Summarizing total sessions and bounced sessions by landing page
SELECT
	t1.landing_page,
	COUNT(DISTINCT t1.website_session_id) AS sessions,
    COUNT(DISTINCT t2.website_session_id) AS bounced_sessions,
    COUNT(DISTINCT t2.website_session_id) / COUNT(DISTINCT t1.website_session_id) AS bounce_rate
FROM test_session_w_lp t1
	LEFT JOIN test_bounced_sessions t2
		ON t1.website_session_id = t2.website_session_id
GROUP BY
	t1.landing_page

    
    