/* 
Ecommerce Analysis: Pull sales data for new product cross-sell analysis 
*/

WITH primary_products AS (
    -- Select orders placed after the new product was added (after '2014-12-05')
    SELECT
        order_id,                  -- Unique order identifier
        primary_product_id,        -- Primary product in the order
        created_at AS ordered_at   -- Timestamp when the order was created
    FROM orders
    WHERE created_at > '2014-12-05'  -- Filter for orders after product launch
)
SELECT
    p.primary_product_id,  
    COUNT(DISTINCT p.order_id) AS total_orders,  
        -- Total unique orders for each primary product

    COUNT(DISTINCT CASE WHEN o.product_id = 1 THEN p.order_id END) AS _xsold_p1,
        -- Unique orders where cross-sell product 1 was added
    COUNT(DISTINCT CASE WHEN o.product_id = 2 THEN p.order_id END) AS _xsold_p2,
        -- Unique orders where cross-sell product 2 was added
    COUNT(DISTINCT CASE WHEN o.product_id = 3 THEN p.order_id END) AS _xsold_p3,
        -- Unique orders where cross-sell product 3 was added
    COUNT(DISTINCT CASE WHEN o.product_id = 4 THEN p.order_id END) AS _xsold_p4,
        -- Unique orders where cross-sell product 4 was added

    COUNT(DISTINCT CASE WHEN o.product_id = 1 THEN p.order_id END) 
        / COUNT(DISTINCT p.order_id) AS p1_xsell_rt,
        -- Cross-sell rate for product 1 (ratio of orders with product 1 cross-sell to total orders)
    COUNT(DISTINCT CASE WHEN o.product_id = 2 THEN p.order_id END) 
        / COUNT(DISTINCT p.order_id) AS p2_xsell_rt,
        -- Cross-sell rate for product 2
    COUNT(DISTINCT CASE WHEN o.product_id = 3 THEN p.order_id END) 
        / COUNT(DISTINCT p.order_id) AS p3_xsell_rt,
        -- Cross-sell rate for product 3
    COUNT(DISTINCT CASE WHEN o.product_id = 4 THEN p.order_id END) 
        / COUNT(DISTINCT p.order_id) AS p4_xsell_rt
        -- Cross-sell rate for product 4
FROM primary_products p
LEFT JOIN order_items o
    ON o.order_id = p.order_id         -- Join to include order items for each order
    AND o.is_primary_item = 0          -- Only include cross-sell items (exclude primary items)
GROUP BY p.primary_product_id;         -- Aggregate results by primary product ID
