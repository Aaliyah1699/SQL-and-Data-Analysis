/*
1. Pull the monthly trends for gsearch sessions and orders. ☑
*/
    
-- Query: Pull the monthly trends for gsearch sessions and orders
SELECT 
    -- Calculate the earliest date for each month 
	MIN(DATE(w.created_at)) AS monthly_trend,
    -- Count the distinct website session IDs to get the total number of sessions for the month.
    COUNT(DISTINCT w.website_session_id) AS sessions,
    -- Count the distinct order IDs to determine how many sessions resulted in orders.
    COUNT(DISTINCT o.order_id) AS order_sessions,
    -- Calculate the conversion rate as the ratio of order sessions to total sessions.
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT w.website_session_id) AS conv_rates
FROM 
    -- Main table containing website session data.
    website_sessions w
    -- LEFT JOIN to include all sessions even if there is no matching order.
	LEFT JOIN orders o
		ON w.website_session_id = o.website_session_id
WHERE 
    -- Filter to include sessions before November 27, 2012.
    w.created_at < '2012-11-27'
	AND 
    -- Filter to include only sessions that originated from Gsearch.
    w.utm_source = 'gsearch'
GROUP BY
    -- Group results by the year of the session creation date.
	YEAR(w.created_at),
    -- Group results by the month of the session creation date.
    MONTH(w.created_at);
