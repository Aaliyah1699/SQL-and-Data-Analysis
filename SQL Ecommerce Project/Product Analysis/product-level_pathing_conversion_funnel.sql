/* Ecommerce Analysis - Product Analysis
~ Learn how customers interact with each product,
and how well each prroduct converts costumers.
Objective:
- Analyze how customers navigate through product pages.
- Compare pre-product vs. post-product launches.
- Understand which product pages users visit next.
*/

-- Product-Level Website Pathing

WITH product_pageviews AS (
    -- STEP 1: Identify relevant product page views and categorize by time period
    SELECT
        website_session_id,
        website_pageview_id,
        created_at,
        CASE
            WHEN created_at < '2013-01-06' THEN 'A: pre_product_2'
            WHEN created_at >= '2013-01-06' THEN 'B: post_product_2'
            ELSE 'Check Logic...'
        END AS time_period
    FROM website_pageviews
    WHERE created_at BETWEEN '2012-10-06' AND '2013-04-06'  -- Date filtering
    AND pageview_url = '/products'
),

sessions_w_next_pv_id AS (
    -- STEP 2: Find the next pageview ID that occurs after product pageview
    SELECT
        p.time_period,
        p.website_session_id,
        MIN(w.website_pageview_id) AS min_next_pv_id  -- Find the earliest next pageview
    FROM product_pageviews p
    LEFT JOIN website_pageviews w 
        ON p.website_session_id = w.website_session_id
        AND w.website_pageview_id > p.website_pageview_id  -- Ensure it's a later pageview
    GROUP BY p.time_period, p.website_session_id
),

sessions_w_next_pv_url AS (
    -- STEP 3: Retrieve the URL associated with the next pageview
    SELECT
        n.time_period,
        n.website_session_id,
        w.pageview_url AS next_pv_url
    FROM sessions_w_next_pv_id n
    LEFT JOIN website_pageviews w 
        ON w.website_pageview_id = n.min_next_pv_id
)

-- STEP 4: Summarize and analyze pre vs. post-product launch behavior
SELECT
    time_period,
    COUNT(DISTINCT website_session_id) AS total_sessions,  -- Total sessions
    COUNT(DISTINCT CASE WHEN next_pv_url IS NOT NULL THEN website_session_id ELSE NULL END) AS sessions_with_next_page,
    -- Calculate the percentage of sessions that moved to another page
    IFNULL(COUNT(DISTINCT CASE WHEN next_pv_url IS NOT NULL THEN website_session_id ELSE NULL END) 
           / NULLIF(COUNT(DISTINCT website_session_id), 0), 0) AS pct_sessions_with_next_page,

    -- Track navigation to specific product pages
    COUNT(DISTINCT CASE WHEN next_pv_url = '/the-original-mr-fuzzy' THEN website_session_id ELSE NULL END) AS to_mrfuzzy,
    IFNULL(COUNT(DISTINCT CASE WHEN next_pv_url = '/the-original-mr-fuzzy' THEN website_session_id ELSE NULL END) 
           / NULLIF(COUNT(DISTINCT website_session_id), 0), 0) AS pct_to_mrfuzzy,

    COUNT(DISTINCT CASE WHEN next_pv_url = '/the-forever-love-bear' THEN website_session_id ELSE NULL END) AS to_lovebear,
    IFNULL(COUNT(DISTINCT CASE WHEN next_pv_url = '/the-forever-love-bear' THEN website_session_id ELSE NULL END) 
           / NULLIF(COUNT(DISTINCT website_session_id), 0), 0) AS pct_to_lovebear
FROM sessions_w_next_pv_url
GROUP BY time_period
ORDER BY time_period;

