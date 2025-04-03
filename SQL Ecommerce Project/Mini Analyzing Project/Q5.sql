/*
5. Pull session to order conversion rates by month
*/
    
SELECT
	MIN(DATE(w.created_at)) AS monthly_trend, -- Get the earliest date of the month as the trend marker
	COUNT(DISTINCT w.website_session_id) AS sessions, -- Count unique sessions per month
	COUNT(DISTINCT o.order_id) AS orders, -- Count unique orders per month
	COUNT(DISTINCT o.order_id) / NULLIF(COUNT(DISTINCT w.website_session_id), 0) AS conversion_rate -- Calculate conversion rate safely
FROM website_sessions w -- Main sessions table
	LEFT JOIN orders o ON w.website_session_id = o.website_session_id -- Join orders table to sessions
WHERE w.created_at < '2012-11-27' -- Filter sessions before the given date
GROUP BY 
YEAR(w.created_at), 
MONTH(w.created_at); -- Group data by year and month

