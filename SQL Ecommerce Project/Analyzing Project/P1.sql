/*Ecommerce Analysis
Objective: 
- Show volume growth by quarter
*/

SELECT
    YEAR(ws.created_at) AS yearly,     -- Extract year from session timestamp
    QUARTER(ws.created_at) AS quartly,   -- Extract quarter from session timestamp
    COUNT(DISTINCT ws.website_session_id) AS sessions,  -- Count unique sessions
    COUNT(DISTINCT o.order_id) AS orders  -- Count unique orders
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id  -- Join sessions with orders
GROUP BY
    YEAR(ws.created_at),             
    QUARTER(ws.created_at)           
ORDER BY
    YEAR(ws.created_at),              
    QUARTER(ws.created_at);           
