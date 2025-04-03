/*  Ecommerce Analysis -
Analyzing Website Performance:
What pages are seen the most by users and to identify where to focus improving business
*/

-- Bounce Rate Analysis

-- Find first website pageview id for revelant sessions
CREATE TEMPORARY TABLE first_pageviews
SELECT
	website_session_id,
    MIN(website_pageview_id) AS min_pgv_id
FROM
	website_pageviews
WHERE created_at < '2012-06-14'
GROUP BY
	website_session_id;

-- Bring in the landing page but only the home page
CREATE TEMPORARY TABLE home_pg_sessions
SELECT 
	t1.website_session_id,
	t2.pageview_url AS landing_page
FROM first_pageviews t1
	LEFT JOIN website_pageviews t2
		ON t2.website_pageview_id = t1.min_pgv_id
WHERE
	t2.pageview_url = '/home';

-- Then a table to have a count of pageviews per session
	-- then limit to just bounced sessions
CREATE TEMPORARY TABLE bounced_sessions
SELECT 
	t1.website_session_id,
    t1.landing_page,
    COUNT(t2.website_pageview_id) AS count_of_pages_viewed
FROM home_pg_sessions t1
	LEFT JOIN website_pageviews t2
		ON t1.website_session_id = t2.website_session_id
GROUP BY 
	t1.website_session_id,
    t1.landing_page
HAVING 
	COUNT(t2.website_pageview_id) = 1; 
    
    
-- Calculating the bounce rates
SELECT
	COUNT(DISTINCT t1.website_session_id) AS sessions,
    COUNT(DISTINCT t2.website_session_id) AS bounced_sessions,
    COUNT(DISTINCT t2.website_session_id) / COUNT(DISTINCT t1.website_session_id) AS bounce_rate
FROM home_pg_sessions t1
    LEFT JOIN bounced_sessions t2
		ON t1.website_session_id = t2.website_session_id;
    
    
