/*Ecommerce Analysis - Product Analysis
Objective: 
- Understand product contributions and the impact of product launches.
- Learn how customers interact with each product and how well each converts customers.
*/

-- Analyzing Product-Level Website Pathing

-- Query 1: Get a distinct list of pageview URLs between February 1 and March 1, 2013.

SELECT DISTINCT 
    pageview_url                 -- Select the unique pageview URL
FROM website_pageviews           -- From the website pageviews table
WHERE created_at BETWEEN '2013-02-01' AND '2013-03-01';  -- Filter for the specified date range (arbitrary)

-- Query 2: Analyze product-level website pathing and conversion rates.

SELECT 
    p.pageview_url,    -- The product page URL being analyzed
    COUNT(DISTINCT p.website_session_id) AS sessions,   -- Count the number of unique website sessions that visited the page                        
    COUNT(DISTINCT o.order_id) AS orders,  -- Count the number of distinct orders placed (from joined orders table)                         
    COUNT(DISTINCT o.order_id) / 
        COUNT(DISTINCT p.website_session_id) AS viewed_prod_to_order_rate  -- Calculate the conversion rate: orders divided by sessions                         
FROM website_pageviews p  -- Use alias 'p' for the website_pageviews table
LEFT JOIN orders o        -- Left join with orders table to include sessions that may not have resulted in orders
    ON o.website_session_id = p.website_session_id  -- Join condition: match website session IDs from both tables
WHERE 
    p.created_at BETWEEN '2013-02-01' AND '2013-03-01'  -- Filter pageviews for the same date range as above
    AND p.pageview_url IN ('/the-original-mr-fuzzy', '/the-forever-love-bear')  -- Consider only the specified product pages
GROUP BY 
    p.pageview_url;      -- Group the results by pageview URL to get per-page aggregates
