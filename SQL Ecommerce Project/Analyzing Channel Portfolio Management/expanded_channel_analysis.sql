/* Ecommerce Analysis-
Analysis for Channel Portfolio Management.
Channel portfolio optimization.
*/

/*
Task:
See how the second paid search channel (bsearch) is doing compared to the
original paid search channel (gsearch).

Pull the weekly trended session volume of bsearch and compare it to 
gsearch nonbrand.
*/

-- Analysis on expanded channel portfolio

SELECT
	MIN(DATE(created_at)) AS week_start_date,
	COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' THEN website_session_id ELSE NULL END) AS gsearch_sessions,
    COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' THEN website_session_id ELSE NULL END) AS bsearch_sessions
FROM website_sessions 
WHERE created_at BETWEEN '2012-08-22' AND '2012-11-29'
	AND utm_campaign = 'nonbrand'
GROUP BY
	YEAR(created_at),
    WEEK(created_at);