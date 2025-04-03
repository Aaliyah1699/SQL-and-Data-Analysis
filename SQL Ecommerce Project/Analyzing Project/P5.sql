/*Ecommerce Analysis
Objective: 
- Pull monthly trending for revenue & margin by product
*/

SELECT
    YEAR(created_at) AS year,                     
    MONTH(created_at) AS month,                   
    SUM(CASE WHEN product_id = 1 THEN price_usd END) AS mr_fuzzy_rev,         -- Revenue for product 1
    SUM(CASE WHEN product_id = 1 THEN price_usd - cogs_usd END) AS mr_fuzzy_marg, -- Margin for product 1
    
    SUM(CASE WHEN product_id = 2 THEN price_usd END) AS lovebear_rev,         -- Revenue for product 2
    SUM(CASE WHEN product_id = 2 THEN price_usd - cogs_usd END) AS lovebear_marg, -- Margin for product 2
    
    SUM(CASE WHEN product_id = 3 THEN price_usd END) AS birthdaybear_rev,         -- Revenue for product 3
    SUM(CASE WHEN product_id = 3 THEN price_usd - cogs_usd END) AS birthdaybear_marg, -- Margin for product 3
    
    SUM(CASE WHEN product_id = 4 THEN price_usd END) AS minibear_rev,         -- Revenue for product 4
    SUM(CASE WHEN product_id = 4 THEN price_usd - cogs_usd END) AS minibear_marg, -- Margin for product 4
    
    SUM(price_usd) AS total_revenue,                
    SUM(price_usd - cogs_usd) AS total_margin         
FROM order_items
GROUP BY
    YEAR(created_at),                             
    MONTH(created_at)                            
ORDER BY
    YEAR(created_at),                             
    MONTH(created_at);                            
