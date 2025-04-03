/*  
    Ecommerce Analysis -
    Analyzing Website Performance:
    What pages are seen the most by users and to identify where to focus improving business
*/

-- Identify which billing page version users see and compare conversion (order) rates.
    -- Conversion Funnel 50/50 Test

/* Step 1: Find the first occurrence of the '/billing-2' page */
SELECT
    MIN(created_at) AS first_created_at,       -- Get the earliest timestamp when '/billing-2' was viewed
    MIN(website_pageview_id) AS first_pv_id       -- Get the smallest pageview ID (assumed to be the first record for '/billing-2')
FROM website_pageviews
WHERE pageview_url = '/billing-2'                -- Only consider the '/billing-2' page
  AND created_at IS NOT NULL;                    -- Exclude any records with missing timestamps
-- Expected result (example): first_created_at = '2012-09-10' and first_pv_id = 53550

/* Step 2: Retrieve sessions where users viewed billing pages along with any associated orders */
SELECT
    p.website_session_id,                         -- Unique session identifier
    p.pageview_url AS billing_version_seen,       -- Which billing version page was seen ('/billing' or '/billing-2')
    o.order_id                                    -- Order ID from the session (if an order was placed)
FROM website_pageviews p
    LEFT JOIN orders o                           -- Left join ensures we include sessions even if no order exists
        ON o.website_session_id = p.website_session_id  -- Match orders to pageviews based on session
WHERE p.website_pageview_id >= 53550             -- Only consider pageviews after the first '/billing-2' (using its pageview id)
  AND p.created_at < '2012-11-10'                  -- Limit to the date range before November 10, 2012
  AND p.pageview_url IN ('/billing', '/billing-2');-- Only include billing-related pages

 -- Step 3: Aggregate sessions by billing version to calculate conversion rates
SELECT
    billing_version_seen,                         -- Billing page version observed in the session
    COUNT(DISTINCT website_session_id) AS sessions,  -- Total unique sessions that viewed this billing version
    COUNT(DISTINCT order_id) AS orders,                -- Total unique orders associated with these sessions
    COUNT(DISTINCT order_id) / COUNT(DISTINCT website_session_id) AS billing_to_order_rt  
        -- Conversion rate: ratio of orders to sessions for this billing version
FROM(
    /* Subquery: Retrieve sessions with billing pageviews and any linked orders */
SELECT
	p.website_session_id,                     -- Session identifier
	p.pageview_url AS billing_version_seen,   -- Billing version seen in the session
	o.order_id                                -- Order ID if the session resulted in an order (may be NULL if no order)
FROM website_pageviews p
	LEFT JOIN orders o                       -- Join orders to include order details if available
		ON o.website_session_id = p.website_session_id
WHERE p.website_pageview_id  >= 53550            -- Only consider records after the first '/billing-2' pageview
	AND p.created_at < '2012-11-10'               -- Restrict to records before November 10, 2012
	AND p.pageview_url IN ('/billing', '/billing-2') -- Filter to include only billing pages
) AS billing_sessions_w_orders                  -- Alias for the subquery results
GROUP BY 
	billing_version_seen                    -- Group by billing version to compare performance of each version
