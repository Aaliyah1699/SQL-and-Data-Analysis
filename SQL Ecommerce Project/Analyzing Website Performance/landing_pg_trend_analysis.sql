/*  Ecommerce Analysis -
Analyzing Website Performance:
What pages are seen the most by users and to identify where to focus improving business
*/

-- Landing page trend analysis

USE mavenfuzzyfactory;

CREATE TEMPORARY TABLE sessions_views
SELECT 
	T1.website_session_id,
	MIN(T2.website_pageview_id) AS first_pageview_id,
    COUNT(T2.website_pageview_id) AS count_pageviews
FROM website_sessions T1
	LEFT JOIN website_pageviews T2
		ON T1.website_session_id = T2.website_session_id
WHERE T1.created_at BETWEEN '2012-06-01' AND '2012-08-31'
    AND utm_campaign = 'nonbrand'
    AND utm_source = 'gsearch'
GROUP BY 
	T1.website_session_id;


CREATE TEMPORARY TABLE sessions_lander
SELECT
	T1.website_session_id,
    T1.first_pageview_id,
    T1.count_pageviews,
    T2.pageview_url AS landing_page,
    T2.created_at AS session_created_at
FROM sessions_views T1
	LEFT JOIN website_pageviews T2
    ON T1.first_pageview_id = T2.website_pageview_id;


SELECT
	YEARWEEK(session_created_at) AS year_week,
    MIN(DATE(session_created_at)) AS week_start_date,
    COUNT(DISTINCT website_session_id) AS total_sessions, 
    COUNT(DISTINCT CASE WHEN count_pageviews = 1 THEN website_session_id ELSE NULL END) AS bounced_sessions,
    COUNT(DISTINCT CASE WHEN count_pageviews = 1 THEN website_session_id ELSE NULL END) * 1.0 / COUNT(DISTINCT website_session_id) AS bounce_rate,
    COUNT(DISTINCT CASE WHEN landing_page = '/home' THEN website_session_id ELSE NULL END) AS home_sessions,
    COUNT(DISTINCT CASE WHEN landing_page = '/lander-1' THEN website_session_id ELSE NULL END) AS lander_sessions
FROM sessions_lander
GROUP BY 
	YEARWEEK(session_created_at)

