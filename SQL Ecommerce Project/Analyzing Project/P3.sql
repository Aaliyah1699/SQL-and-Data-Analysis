/*Ecommerce Analysis
Objective: 
- Show how specific channels have grown
*/

SELECT	
    YEAR(ws.created_at) AS yearly,               
    QUARTER(ws.created_at) AS quartly,             
    COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN o.order_id END) AS gsearch_nonbrand_orders,  -- gsearch nonbrand orders
    COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN o.order_id END) AS bsearch_nonbrand_orders,  -- bsearch nonbrand orders
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN o.order_id END) AS brand_search_orders,   -- Brand search orders
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN o.order_id END) AS organic_search_orders,  -- Organic orders
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN o.order_id END) AS direct_type_in_orders   -- Direct orders
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id  -- Join sessions to orders
GROUP BY
    YEAR(ws.created_at),        
    QUARTER(ws.created_at)         
ORDER BY
    YEAR(ws.created_at),         
    QUARTER(ws.created_at);      

