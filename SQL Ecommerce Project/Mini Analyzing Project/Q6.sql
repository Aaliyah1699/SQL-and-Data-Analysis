/*
6. For the previous gsearch lander test, esitmate the revenue that test earrned.
Look at the increase in cvr from the test (jun 19 - jul 28), aand use nonbrand sessions
& revenue since then to calculate incremental value
*/

-- Find the first pageview id for lander-1
SELECT
	MIN(website_pageview_id) AS first_pv -- get the smallest pageview ID for '/lander-1'
FROM website_pageviews
WHERE pageview_url = '/lander-1'; -- filter for lander-1 page

-- Create a temporary table with the first pageview per session for test sessions
CREATE TEMPORARY TABLE first_test_pv
SELECT
	p.website_session_id, -- session identifier
	MIN(p.website_pageview_id) AS min_pv_id -- get the first pageview ID for the session
FROM website_pageviews p
	INNER JOIN website_sessions s
		ON p.website_session_id = s.website_session_id -- join sessions to pageviews
		AND s.created_at < '2012-07-28' -- only sessions before July 28, 2012
		AND p.website_pageview_id >= 23504 -- only pageviews with ID >= 23504
		AND s.utm_source = 'gsearch' -- filter for gsearch sessions
		AND s.utm_campaign = 'nonbrand' -- filter for nonbrand campaign sessions
GROUP BY p.website_session_id; -- group by session

-- Create a temporary table to link each test session to its landing page
CREATE TEMPORARY TABLE test_sessions_landing
SELECT
	f.website_session_id, -- session identifier from first_test_pv
	p.pageview_url AS landing_pg -- corresponding landing page URL
FROM first_test_pv f
	LEFT JOIN website_pageviews p
		ON f.min_pv_id = p.website_pageview_id -- join to get pageview details
WHERE p.pageview_url IN ('/home', '/lander-1'); -- only keep sessions landing on /home or /lander-1

-- Create a temporary table to attach orders to each test session
CREATE TEMPORARY TABLE test_sessions_orders
SELECT
	t.website_session_id, -- session identifier
	t.landing_pg, -- landing page from test_sessions_landing
	o.order_id AS order_id -- associated order ID, if any
FROM test_sessions_landing t
	LEFT JOIN orders o
		ON o.website_session_id = t.website_session_id; -- join orders to sessions

-- Aggregate conversion rates by landing page for test sessions
SELECT
	landing_pg, -- landing page grouping
	COUNT(DISTINCT website_session_id) AS sessions, -- count sessions per landing page
	COUNT(DISTINCT order_id) AS orders, -- count orders per landing page
	COUNT(DISTINCT order_id) / COUNT(DISTINCT website_session_id) AS conversion_rate -- compute conversion rate
FROM test_sessions_orders
GROUP BY 1; -- group by landing page

-- Find the most recent pageview for gsearch nonbrand sessions directed to /home
SELECT
	MAX(s.website_session_id) AS gsearch_home_pv -- get the maximum session id as a reference
FROM website_sessions s
	LEFT JOIN website_pageviews p
		ON p.website_session_id = s.website_session_id -- join sessions to pageviews
WHERE s.utm_source = 'gsearch' -- filter for gsearch
	AND s.created_at < '2012-11-27' -- only sessions before November 27, 2012
	AND p.pageview_url = '/home' -- pageview must be /home
	AND s.utm_campaign = 'nonbrand'; -- filter for nonbrand campaign

-- Count sessions since the test based on session IDs
SELECT
	COUNT(website_session_id) AS sessions_since_test -- count sessions after a given session ID threshold
FROM website_sessions
WHERE created_at < '2012-11-27' -- sessions before the given date
	AND website_session_id > 17145 -- session IDs after the test threshold
	AND utm_source = 'gsearch' -- filter for gsearch sessions
	AND utm_campaign = 'nonbrand'; -- filter for nonbrand campaign

/*
22972 web sessions since test
X .0087 incremental conversion = 202 incremental orders
since 7/29/2012
About 50 extra orders per month
*/
