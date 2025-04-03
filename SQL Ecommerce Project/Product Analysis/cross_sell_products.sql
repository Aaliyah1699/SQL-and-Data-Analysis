/*Ecommerce Analysis - Product Analysis
Objective: 
- Identify which products are most likely to be purchased together (cross-selling) 
  to enable smart product recommendations.
*/

-- Cross-Selling Products & Product Portfolio Analysis

-- Step 1: Pre-aggregate each order with flags for cross-sell products using a CTE
WITH cross_sell_data AS (
    SELECT 
        o.primary_product_id,                  -- The primary product identifier for the order
        o.order_id,                            -- Unique order identifier
        /* For each cross-sell product, determine if the order includes it.
           Using MAX() with a CASE returns 1 if at least one matching record exists, otherwise 0.
        */
        MAX(CASE WHEN i.product_id = 1 THEN 1 ELSE 0 END) AS has_cross_sell_prod1,
        MAX(CASE WHEN i.product_id = 2 THEN 1 ELSE 0 END) AS has_cross_sell_prod2,
        MAX(CASE WHEN i.product_id = 3 THEN 1 ELSE 0 END) AS has_cross_sell_prod3
    FROM orders o
    LEFT JOIN order_items i
        ON o.order_id = i.order_id          -- Join orders with order items
        AND i.is_primary_item = 0           -- Include only non-primary items (cross-sell items)
    WHERE o.order_id BETWEEN 10000 AND 11000 -- Filter orders within an arbitrary range
    GROUP BY o.primary_product_id, o.order_id  -- One row per order (per primary product)
)

-- Step 2: Aggregate the pre-aggregated data by primary product
SELECT 
    primary_product_id,                          -- Primary product from the order
    COUNT(*) AS orders,                          -- Total number of orders for this primary product
    SUM(has_cross_sell_prod1) AS cross_sell_prod1,  -- Total orders that cross-sold product 1
    SUM(has_cross_sell_prod2) AS cross_sell_prod2,  -- Total orders that cross-sold product 2
    SUM(has_cross_sell_prod3) AS cross_sell_prod3,  -- Total orders that cross-sold product 3
    /* Calculate the cross-sell rate by dividing the number of orders with the cross-sell 
       product by the total orders for the primary product. */
    SUM(has_cross_sell_prod1) / COUNT(*) AS cross_sell_prod1_rate,
    SUM(has_cross_sell_prod2) / COUNT(*) AS cross_sell_prod2_rate,
    SUM(has_cross_sell_prod3) / COUNT(*) AS cross_sell_prod3_rate
FROM cross_sell_data
GROUP BY 
	primary_product_id      -- Group by primary product to summarize the data
ORDER BY 
	primary_product_id;     -- Order the results by primary product for clarity
