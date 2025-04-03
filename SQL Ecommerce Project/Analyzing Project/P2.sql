/*Ecommerce Analysis
Objective: 
- Showcase effiency improvements
*/

SELECT
    YEAR(ws.created_at) AS yearly,             
    QUARTER(ws.created_at) AS quartly,          
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) AS conv_rate,  -- Conversion rate
    SUM(price_usd) / COUNT(DISTINCT o.order_id) AS rev_per_order,  -- Revenue per order
    SUM(price_usd) / COUNT(DISTINCT ws.website_session_id) AS rev_per_session  -- Revenue per session
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id  -- Link sessions to orders
GROUP BY
    YEAR(ws.created_at),                        
    QUARTER(ws.created_at)                       
ORDER BY
    YEAR(ws.created_at),                       
    QUARTER(ws.created_at);                     
