/*
3. For gsearch nonbrand, pull monthly sessions & orders, split by device type
*/
    
-- For gsearch nonbrand, pull monthly sessions & orders, split by device type
SELECT
	MIN(DATE(w.created_at)) AS monthly_trend, -- first day of the month
	COUNT(DISTINCT w.website_session_id) AS sessions, -- total sessions in the month
	COUNT(DISTINCT CASE WHEN w.device_type = 'desktop' THEN w.website_session_id ELSE NULL END) AS desktop_sessions, -- sessions on desktop
	COUNT(DISTINCT CASE WHEN w.device_type = 'mobile' THEN w.website_session_id ELSE NULL END) AS mobile_sessions, -- sessions on mobile
	COUNT(DISTINCT CASE WHEN w.device_type = 'desktop' THEN o.order_id ELSE NULL END) AS desktop_orders, -- orders from desktop sessions
	COUNT(DISTINCT CASE WHEN w.device_type = 'mobile' THEN o.order_id ELSE NULL END) AS mobile_orders -- orders from mobile sessions
FROM website_sessions w -- main sessions table
	LEFT JOIN orders o 
    ON w.website_session_id = o.website_session_id -- join orders table
WHERE w.created_at < '2012-11-27' -- sessions before the date
	AND w.utm_source = 'gsearch' -- only gsearch sessions
	AND w.utm_campaign = 'nonbrand' -- only nonbrand campaign sessions
GROUP BY 
	YEAR(w.created_at), 
    MONTH(w.created_at); -- group results by year and month
