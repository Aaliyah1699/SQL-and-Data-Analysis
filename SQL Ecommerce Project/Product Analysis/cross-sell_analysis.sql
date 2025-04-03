/* Ecommerce Analysis - Product Analysis
~ Understanding which products users are most likely to 
purchase together, and offering smart product reccomendations.
*/

-- Cross-Sell Analysis

WITH sessions_seeing_cart AS (
    -- Identifies sessions where users viewed the cart page
    SELECT 
        CASE 
            WHEN created_at < '2013-09-25' THEN 'A: pre_cross_sell'
            WHEN created_at >= '2013-09-25' THEN 'B: post_cross_sell'
            ELSE 'Check Logic...'
        END AS time_period,
        website_session_id AS cart_session_id,
        website_pageview_id AS cart_pageview_id
    FROM website_pageviews
    WHERE created_at BETWEEN '2012-08-25' AND '2013-10-25'
    AND pageview_url = '/cart'
),

cart_sessions_seeing_another_pg AS (
    -- Identifies sessions where users navigated to another page after viewing the cart
    SELECT 
        s.time_period,
        s.cart_session_id,
        MIN(p.website_pageview_id) AS pv_id_after_cart
    FROM sessions_seeing_cart s
    LEFT JOIN website_pageviews p
        ON s.cart_session_id = p.website_session_id
        AND p.website_pageview_id > s.cart_pageview_id
    WHERE p.website_pageview_id IS NOT NULL
    GROUP BY s.time_period, s.cart_session_id
),

pre_post_session_orders AS (
    -- Links cart sessions to orders placed
    SELECT 
        s.time_period,
        s.cart_session_id,
        o.order_id,
        o.items_purchased,
        o.price_usd
    FROM sessions_seeing_cart s
    INNER JOIN orders o -- Only include sessions where an order was placed
        ON s.cart_session_id = o.website_session_id
)

-- Final Analysis: Aggregating cart interactions, conversions, and revenue
SELECT 
    time_period,
    COUNT(DISTINCT cart_session_id) AS cart_sessions, -- Total sessions that saw the cart
    SUM(clicked_to_another_pg) AS clickthroughs, -- Users who clicked to another page
    SUM(clicked_to_another_pg) / COUNT(DISTINCT cart_session_id) AS cart_ctr, -- Cart clickthrough rate
    SUM(placed_order) AS orders_placed, -- Total orders placed
    SUM(items_purchased) AS prods_purchased, -- Total products purchased
    SUM(items_purchased) / NULLIF(SUM(placed_order), 0) AS products_per_order, -- Average items per order
    SUM(price_usd) AS revenue, -- Total revenue generated
    SUM(price_usd) / NULLIF(SUM(placed_order), 0) AS aov, -- Average order value (AOV)
    SUM(price_usd) / COUNT(DISTINCT cart_session_id) AS rev_per_cart_session -- Revenue per cart session
FROM (
    -- Combining all calculated data into a single dataset
    SELECT 
        s.time_period,
        s.cart_session_id,
        CASE WHEN c.cart_session_id IS NULL THEN 0 ELSE 1 END AS clicked_to_another_pg, -- User clicked another page
        CASE WHEN p.order_id IS NULL THEN 0 ELSE 1 END AS placed_order, -- User placed an order
        COALESCE(p.items_purchased, 0) AS items_purchased, -- Total items bought
        COALESCE(p.price_usd, 0) AS price_usd -- Revenue generated
    FROM sessions_seeing_cart s
    LEFT JOIN cart_sessions_seeing_another_pg c 
        ON s.cart_session_id = c.cart_session_id
    LEFT JOIN pre_post_session_orders p 
        ON s.cart_session_id = p.cart_session_id
) AS full_data
GROUP BY time_period;

    