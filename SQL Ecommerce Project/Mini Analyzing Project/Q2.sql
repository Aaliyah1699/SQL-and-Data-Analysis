/*
2. Pull the monthly trend fro gsearch, spitting barnd & nonbrand to see if brand is picking up
*/

-- Pull monthly trends for gsearch, splitting brand and nonbrand
SELECT
	MIN(DATE(w.created_at)) AS monthly_trend, -- get the first day of the month
	COUNT(DISTINCT w.website_session_id) AS sessions, -- total sessions in the month
	COUNT(DISTINCT CASE WHEN w.utm_campaign = 'nonbrand' THEN w.website_session_id ELSE NULL END) AS nonbrand_sessions, -- sessions with nonbrand campaign
	COUNT(DISTINCT CASE WHEN w.utm_campaign = 'brand' THEN w.website_session_id ELSE NULL END) AS brand_sessions, -- sessions with brand campaign
	COUNT(DISTINCT CASE WHEN w.utm_campaign = 'nonbrand' THEN o.order_id ELSE NULL END) AS nonbrand_orders, -- orders from nonbrand sessions
	COUNT(DISTINCT CASE WHEN w.utm_campaign = 'brand' THEN o.order_id ELSE NULL END) AS brand_orders -- orders from brand sessions
FROM website_sessions w -- main table for website sessions
	LEFT JOIN orders o -- join orders table to include sessions without orders
	ON w.website_session_id = o.website_session_id -- join condition
WHERE w.created_at < '2012-11-27' -- include sessions before this date
	AND w.utm_source = 'gsearch' -- only sessions from Gsearch
GROUP BY
	YEAR(w.created_at), -- group by year of the session
	MONTH(w.created_at); -- group by month of the session
