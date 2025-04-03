/* Ecommerce Analysis-
Analysis for Channel Portfolio Management.
Channel portfolio optimization.
*/

-- Cross channel bid optimization
SELECT
	s.device_type,
    s.utm_source,
    COUNT(DISTINCT s.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT s.website_session_id) AS conv_rate
FROM website_sessions s
	LEFT JOIN orders o
		ON s.website_session_id = o.website_session_id
WHERE s.created_at BETWEEN '2012-08-22' AND '2012-09-19'
	AND s.utm_campaign = 'nonbrand'
GROUP BY 1,2;