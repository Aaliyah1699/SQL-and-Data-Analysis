/*Ecommerce Analysis
Objective: 
- Show overall conversion rate trends
*/

SELECT	
    YEAR(ws.created_at) AS yearly,                     -- Year of session
    QUARTER(ws.created_at) AS quartly,                  -- Quarter of session
    COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' 
                           AND utm_campaign = 'nonbrand' 
                        THEN o.order_id END) 
        / COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' 
                               AND utm_campaign = 'nonbrand' 
                            THEN ws.website_session_id END) AS gsearch_nonbrand_conv_rt,  -- gsearch nonbrand conversion rate
                            
    COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' 
                           AND utm_campaign = 'nonbrand' 
                        THEN o.order_id END) 
        / COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' 
                               AND utm_campaign = 'nonbrand' 
                            THEN ws.website_session_id END) AS bsearch_nonbrand_conv_rt,  -- bsearch nonbrand conversion rate
                            
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' 
                        THEN o.order_id END) 
        / COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' 
                              THEN ws.website_session_id END) AS brand_search_orders,  -- brand search conversion rate
                              
    COUNT(DISTINCT CASE WHEN utm_source IS NULL 
                             AND http_referer IS NOT NULL 
                        THEN o.order_id END) 
        / COUNT(DISTINCT CASE WHEN utm_source IS NULL 
                              AND http_referer IS NOT NULL 
                           THEN ws.website_session_id END) AS organic_search_conv_rt,  -- organic search conversion rate
                           
    COUNT(DISTINCT CASE WHEN utm_source IS NULL 
                             AND http_referer IS NULL 
                        THEN o.order_id END) 
        / COUNT(DISTINCT CASE WHEN utm_source IS NULL 
                              AND http_referer IS NULL 
                           THEN ws.website_session_id END) AS direct_type_in_conv_rt  -- direct type-in conversion rate
        
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id  -- Link sessions to orders
GROUP BY
    YEAR(ws.created_at),                            
    QUARTER(ws.created_at)                             
ORDER BY
    YEAR(ws.created_at),                            
    QUARTER(ws.created_at);                           
