/* Ecommerce Analysis-
Product Analysis.
~ Understand how each product contributes to business, 
and how product launces impact the overall portfollio.
*/

-- Product Sales Analysis
SELECT
	primary_product_id,
	COUNT(order_id) AS orders,
    SUM(price_usd) AS revenue,
    SUM(price_usd - cogs_usd) AS margin,
    AVG(price_usd) AS aov -- average order value
FROM orders
WHERE order_id BETWEEN 10000 AND 11000 -- arbitrary
GROUP BY 1
ORDER BY 2 DESC