/* Ecommerce Analysis-
Product Analysis.
Objective: 
- Understand product contributions to business revenue.
- Analyze sales trends and product launches' impact.
*/

-- Product-Level Sales Analysis

SELECT 
    DATE_FORMAT(created_at, '%Y-%m') AS yearmonth,  -- Format date as 'YYYY-MM' 
    COUNT(order_id) AS num_of_sales,  -- Count total sales
    SUM(COALESCE(price_usd, 0)) AS total_revenue,  -- Handle NULL values in price
    SUM(COALESCE(price_usd, 0) - COALESCE(cogs_usd, 0)) AS total_margin  -- Calculate profit margin safely (prevent error if null)
FROM orders
WHERE created_at < '2013-01-04'  -- Filter for records before January 4, 2013
GROUP BY yearmonth  -- Group by formatted date
ORDER BY yearmonth;  -- Ensure results are in chronological order
