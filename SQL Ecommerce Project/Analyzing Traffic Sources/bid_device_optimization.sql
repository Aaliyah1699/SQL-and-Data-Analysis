/* Ecommerce Analysis -
Traffic Source Analysis:
Where customer's are coming from & which channels are driving the highest quality traffic
*/

-- Bid Optimization

USE mavenfuzzyfactory;

SELECT 
device_type,
	COUNT(DISTINCT t1.website_session_id) AS sessions,
    COUNT(DISTINCT t2.order_id) AS orders,
    COUNT(DISTINCT t2.order_id) / COUNT(DISTINCT t1.website_session_id) AS session_to_order_cov_rt -- Analyze conversion rate

FROM website_sessions t1 -- Table 1
	LEFT JOIN orders t2 -- Table 2
		ON t2.website_session_id = t1.website_session_id -- Left join orders table matching ids
WHERE t1.created_at < '2012-05-11'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY device_type
