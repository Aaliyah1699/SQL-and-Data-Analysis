/* 
Ecommerce Analysis: Show improvements for /products
*/

WITH product_pageviews AS (
    -- Get /products pageviews
    SELECT 
        website_session_id,         -- Session ID
        website_pageview_id,        -- Pageview ID
        created_at AS saw_prod_pg_at -- View timestamp
    FROM website_pageviews
    WHERE pageview_url = '/products'  -- Filter for /products page
)
SELECT 
    YEAR(saw_prod_pg_at) AS year,             -- Year of view
    MONTH(saw_prod_pg_at) AS month,            -- Month of view
    COUNT(DISTINCT p.website_session_id) AS sessions_to_prod_pg,  -- Unique sessions
    COUNT(DISTINCT w.website_session_id) AS clicked_to_next_pg,   -- Sessions with next page view
    COUNT(DISTINCT w.website_session_id) / COUNT(DISTINCT p.website_session_id) AS clickthrough_rt,  -- CTR
    COUNT(DISTINCT o.order_id) AS orders,       -- Unique orders
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT p.website_session_id) AS prod_to_order_rt  -- Conversion rate
FROM product_pageviews p
LEFT JOIN website_pageviews w
    ON p.website_session_id = w.website_session_id  
    /* Optional: AND w.created_at > p.saw_prod_pg_at */
LEFT JOIN orders o
    ON o.website_session_id = p.website_session_id
GROUP BY
    YEAR(saw_prod_pg_at),
    MONTH(saw_prod_pg_at);
