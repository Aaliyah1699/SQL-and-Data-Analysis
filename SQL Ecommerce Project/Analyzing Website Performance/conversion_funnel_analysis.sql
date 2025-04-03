/*  Ecommerce Analysis -
Analyzing Website Performance:
What pages are seen the most by users and to identify where to focus improving business
*/
-- Analyzing Conversion Funnel
-- Combined Query: Using CTEs for a single-statement conversion funnel analysis

WITH filtered_pageviews AS (
    -- Step 1: Filter relevant pageviews for sessions in the specified date range and for funnel pages.
    SELECT
        s.website_session_id,                          -- Unique session identifier
        p.pageview_url,                                -- URL of the page viewed
        p.created_at AS pageview_created_at,           -- Timestamp when the page was viewed
        CASE WHEN p.pageview_url = '/products' THEN 1 ELSE 0 END AS products_page,  -- Flag for '/products' page
        CASE WHEN p.pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,  -- Flag for '/the-original-mr-fuzzy' page
        CASE WHEN p.pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,  -- Flag for '/cart' page
        CASE WHEN p.pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,  -- Flag for '/shipping' page
        CASE WHEN p.pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,  -- Flag for '/billing' page
        CASE WHEN p.pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page  -- Flag for '/thank-you' page
    FROM website_sessions s
    LEFT JOIN website_pageviews p
        ON s.website_session_id = p.website_session_id  -- Join sessions with pageviews
    WHERE s.created_at BETWEEN '2012-08-05' AND '2012-09-05'  -- Filter sessions within these dates
      AND p.pageview_url IN ('/lander-1', '/products', '/the-original-mr-fuzzy', '/cart', '/shipping', '/billing', '/thank-you-for-your-order')  -- Only include funnel-related pages
      
),
session_funnel AS (
    -- Step 2: Aggregate page-level data to a session-level summary of conversion flags.
    SELECT
        website_session_id,  -- Unique session identifier
        MAX(products_page) AS product_made_it,     -- 1 if session visited '/products'
        MAX(mrfuzzy_page) AS mrfuzzy_made_it,        -- 1 if session visited '/the-original-mr-fuzzy'
        MAX(cart_page) AS cart_made_it,               -- 1 if session visited '/cart'
        MAX(shipping_page) AS shipping_made_it,               -- 1 if session visited '/shipping'
        MAX(billing_page) AS billing_made_it,               -- 1 if session visited '/billing'
        MAX(thankyou_page) AS thankyou_made_it               -- 1 if session visited '/thank-you'
    FROM filtered_pageviews
	GROUP BY website_session_id
	)
-- Step 3: Calculate clickthrough rates between funnel stages.
SELECT
    COUNT(DISTINCT website_session_id) AS sessions,  -- Total unique sessions
    -- Clickthrough rate from landing page to '/products'
    COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
        / COUNT(DISTINCT website_session_id) AS lander_clickthrough_rate,
    -- Clickthrough rate from '/products' to '/the-original-mr-fuzzy'
    COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0 -- multiply by 1.0 to ensure the division produces a floating-point result
        / NULLIF(COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS products_clickthrough_rate,
    -- Clickthrough rate from '/the-original-mr-fuzzy' to '/cart'
    COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
        / NULLIF(COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS mrfuzzy_clickthrough_rate,
	-- Clickthrough rate from '/cart' to '/shipping'
    COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
        / NULLIF(COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS cart_clickthrough_rate,
	-- Clickthrough rate from '/shipping' to '/billing'
    COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
        / NULLIF(COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS shipping_clickthrough_rate,
	-- Clickthrough rate from '/billing' to '/thank-you'
    COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
        / NULLIF(COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS billing_clickthrough_rate
FROM session_funnel;