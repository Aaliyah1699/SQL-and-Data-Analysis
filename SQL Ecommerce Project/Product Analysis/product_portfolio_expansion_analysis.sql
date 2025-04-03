/* Ecommerce Analysis - Product Analysis
~ Identifying product purchases together and calculating key metrics.
*/

-- Product Portfolio Expansion

-- Time Period for Analysis: Using a simple CASE statement to categorize sessions by time
SELECT
    -- Using CASE to categorize sessions into pre-cross-sell and post-cross-sell based on created_at
    CASE
        WHEN s.created_at < '2013-12-12' THEN 'A: pre_cross_sell'
        WHEN s.created_at >= '2013-01-06' THEN 'B: post_cross_sell'
        ELSE 'Check Logic...'
    END AS time_period,
    
    -- number of unique sessions
    COUNT(DISTINCT s.website_session_id) AS sessions,
    -- number of unique orders 
    COUNT(DISTINCT o.order_id) AS orders,    
    -- Conversion Rate: Number of orders divided by the number of sessions
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT s.website_session_id) AS conv_rate,    
    -- Total Revenue: Summing up the revenue from all orders
    SUM(o.price_usd) AS total_revenue,    
    -- Total Products Sold: Summing up the quantity of items purchased across all orders
    SUM(o.items_purchased) AS total_prod_sold,    
    -- Average Order Value: Total revenue divided by the number of orders
    SUM(o.price_usd) / COUNT(DISTINCT o.order_id) AS avg_order_value,    
    -- Products Per Order: Total products sold divided by the number of orders
    SUM(o.items_purchased) / COUNT(DISTINCT o.order_id) AS products_per_order, 
    -- Revenue Per Session: Total revenue divided by the number of sessions
    SUM(o.price_usd) / COUNT(DISTINCT s.website_session_id) AS revenue_per_session
FROM website_sessions s
-- ensure all sessions are included, even those with no orders
LEFT JOIN orders o
    ON s.website_session_id = o.website_session_id
-- Filtering sessions within a specific time window 
WHERE s.created_at BETWEEN '2013-11-12' AND '2014-01-12'
-- Grouping results by the time period to analyze pre and post cross-sell performance
GROUP BY 1;

