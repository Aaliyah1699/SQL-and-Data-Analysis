/* Ecommerce Analysis-
Analysis for Channel Portfolio Management.
Channel portfolio optimization.
*/

-- Analyzing Channel Portfolios

SELECT
	w.utm_content,
    COUNT(DISTINCT w.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT w.website_session_id) AS conversion_rate
FROM website_sessions w
	LEFT JOIN orders o
		ON w.website_session_id = o.website_session_id
WHERE w.created_at BETWEEN '2014-01-01' AND '2014-02-01' -- arbitrary
GROUP BY 1
ORDER BY sessions DESC
    