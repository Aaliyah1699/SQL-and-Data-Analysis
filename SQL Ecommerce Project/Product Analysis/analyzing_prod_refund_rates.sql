/* Ecommerce Analysis - Product Analysis
Objective: 
- Control for quality by analyzing product refund rates.
- Identify products with higher refund rates that might require attention.
*/

-- Analyzing Product refund rates

-- CTE to aggregate orders and refunds per year, month, and product
WITH product_aggregates AS (
    SELECT
        YEAR(i.created_at) AS yr,                      -- Extract the year from the order creation date
        MONTH(i.created_at) AS mo,                     -- Extract the month from the order creation date
        i.product_id,                                  -- Product identifier (e.g., 1, 2, 3, or 4)
        COUNT(DISTINCT i.order_item_id) AS orders,       -- Count distinct order items for the product
        COUNT(DISTINCT r.order_item_id) AS refunds       -- Count distinct refunded order items for the product
    FROM order_items i
    LEFT JOIN order_item_refunds r
        ON i.order_item_id = r.order_item_id          -- Join refunds table on order item ID
    WHERE i.created_at < '2014-10-15'                  -- Filter for orders before October 15, 2014
    GROUP BY yr, mo, i.product_id                      -- Group by year, month, and product to get aggregates
)

-- Pivot the aggregated data to output one row per year and month with metrics for each product
SELECT
    yr,                                               -- Year of the orders
    mo,                                               -- Month of the orders
    
    -- For Product 1: Retrieve total orders and compute refund rate
    COALESCE(MAX(CASE WHEN product_id = 1 THEN orders END), 0) AS p1_orders,  -- Total orders for product 1; COALESCE to return 0 if no data
    COALESCE(MAX(CASE WHEN product_id = 1 THEN refunds END), 0) / 
        NULLIF(COALESCE(MAX(CASE WHEN product_id = 1 THEN orders END), 0), 0) AS p1_refund_rt,  -- Refund rate for product 1; use NULLIF to avoid division by zero
    
    -- For Product 2: Retrieve total orders and compute refund rate
    COALESCE(MAX(CASE WHEN product_id = 2 THEN orders END), 0) AS p2_orders,  -- Total orders for product 2
    COALESCE(MAX(CASE WHEN product_id = 2 THEN refunds END), 0) / 
        NULLIF(COALESCE(MAX(CASE WHEN product_id = 2 THEN orders END), 0), 0) AS p2_refund_rt,  -- Refund rate for product 2
    
    -- For Product 3: Retrieve total orders and compute refund rate
    COALESCE(MAX(CASE WHEN product_id = 3 THEN orders END), 0) AS p3_orders,  -- Total orders for product 3
    COALESCE(MAX(CASE WHEN product_id = 3 THEN refunds END), 0) / 
        NULLIF(COALESCE(MAX(CASE WHEN product_id = 3 THEN orders END), 0), 0) AS p3_refund_rt,  -- Refund rate for product 3
    
    -- For Product 4: Retrieve total orders and compute refund rate
    COALESCE(MAX(CASE WHEN product_id = 4 THEN orders END), 0) AS p4_orders,  -- Total orders for product 4
    COALESCE(MAX(CASE WHEN product_id = 4 THEN refunds END), 0) / 
        NULLIF(COALESCE(MAX(CASE WHEN product_id = 4 THEN orders END), 0), 0) AS p4_refund_rt   -- Refund rate for product 4
FROM product_aggregates
GROUP BY yr, mo                                   -- Group by year and month to consolidate the pivoted data
ORDER BY yr, mo;                                  -- Order the results chronologically
