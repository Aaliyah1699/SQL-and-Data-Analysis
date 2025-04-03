/* Ecommerce Analysis – Product Analysis
Objective:
- Track website sessions and orders over time.
- Measure conversion rate and revenue per session.
- Analyze the performance of new product launches.
*/

-- Analyzing Product launches

-- Aggregate data for sessions, orders, and product-specific purchases
SELECT
    DATE_FORMAT(s.created_at, '%Y-%m') AS yearmonth,  -- Format as 'YYYY-MM'
    COUNT(DISTINCT s.website_session_id) AS total_sessions,  -- Count unique website sessions
    COUNT(DISTINCT o.order_id) AS total_orders,  -- Count unique orders
    -- Conversion Rate: Orders per session (Avoid division by zero)
    IFNULL(COUNT(DISTINCT o.order_id) / NULLIF(COUNT(DISTINCT s.website_session_id), 0), 0) AS conv_rate,  
    -- Revenue per session (Handle NULL values in revenue)
    IFNULL(SUM(o.price_usd) / NULLIF(COUNT(DISTINCT s.website_session_id), 0), 0) AS revenue_per_session,
    -- Count orders for specific products
    SUM(CASE WHEN o.primary_product_id = 1 THEN 1 ELSE 0 END) AS prod_one_orders,
    SUM(CASE WHEN o.primary_product_id = 2 THEN 1 ELSE 0 END) AS prod_two_orders
FROM website_sessions s
LEFT JOIN orders o ON o.website_session_id = s.website_session_id  -- Join sessions with orders
WHERE s.created_at BETWEEN '2012-05-01' AND '2013-05-01'  -- Filter sessions within date range
GROUP BY yearmonth  -- Group data by year-month
ORDER BY yearmonth;  -- Sort results in chronological order
