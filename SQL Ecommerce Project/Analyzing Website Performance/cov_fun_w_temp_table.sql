/*  Ecommerce Analysis -
Analyzing Website Performance:
What pages are seen the most by users and to identify where to focus improving business
*/
-- Conversion funnel 
-- Step 1: Create a temporary table to store session-level conversion flags
CREATE TEMPORARY TABLE session_funnel AS
WITH filtered_pageviews AS (
    SELECT
        s.website_session_id,
        p.pageview_url,
        p.created_at AS pageview_created_at,
        CASE WHEN p.pageview_url = '/products' THEN 1 ELSE 0 END AS products_page,
        CASE WHEN p.pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
        CASE WHEN p.pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page
    FROM website_sessions s
    LEFT JOIN website_pageviews p
        ON s.website_session_id = p.website_session_id
    WHERE s.created_at BETWEEN '2014-01-01' AND '2014-02-01'
      AND p.pageview_url IN ('/lander-2', '/products', '/the-original-mr-fuzzy', '/cart')
)
SELECT
    website_session_id,
    MAX(products_page) AS product_made_it,
    MAX(mrfuzzy_page) AS mrfuzzy_made_it,
    MAX(cart_page) AS cart_made_it
FROM filtered_pageviews
GROUP BY website_session_id;

-- Step 2: Calculate clickthrough rates using the temporary table.
SELECT
    COUNT(DISTINCT website_session_id) AS sessions,  -- Total unique sessions
    COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
        / COUNT(DISTINCT website_session_id) AS lander_clickthrough_rate,
    COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
        / NULLIF(COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS products_clickthrough_rate,
    COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
        / NULLIF(COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS mrfuzzy_clickthrough_rate
FROM session_funnel;
