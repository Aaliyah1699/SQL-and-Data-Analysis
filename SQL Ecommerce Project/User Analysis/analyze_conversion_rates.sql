/*Ecommerce Analysis - User Analysis
Objective: 
- Analyze repeat activity to see how often customers
	are coming back and visiting  the site
*/

-- Analyze new & repeat conversion rates
SELECT
    is_repeat_session,  -- 0: new, 1: repeat
    COUNT(DISTINCT w.website_session_id) AS total_sessions,  -- Count unique sessions
    ROUND(
        COUNT(DISTINCT o.order_id) / NULLIF(COUNT(DISTINCT w.website_session_id), 0) * 100, 2
    ) AS conversion_rate_pct,  -- % sessions with orders
    ROUND(
        SUM(COALESCE(price_usd, 0)) / NULLIF(COUNT(DISTINCT w.website_session_id), 0), 2
    ) AS revenue_per_session  -- Average revenue per session
FROM website_sessions w
LEFT JOIN orders o ON w.website_session_id = o.website_session_id  -- Match orders to sessions
WHERE w.created_at BETWEEN '2014-01-01' AND '2014-11-08'  -- Filter by date range
GROUP BY is_repeat_session  -- Group by session type
ORDER BY is_repeat_session;  -- Order by session type
