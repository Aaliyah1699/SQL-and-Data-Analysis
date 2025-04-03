/* Ecommerce Analysis ~
Analyzing Business Patterns and Seasonality.
Generate insightsto help maximize efficiency 
and anticipate future trends.
*/

-- Analyzing Seasonality
	-- for all of 2012

-- 1st analysis will seperate the yeaar and month into their own columns
SELECT
	YEAR(s.created_at) AS yr,
    MONTH(s.created_at) AS mo,
    COUNT(DISTINCT s.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions s
    LEFT JOIN orders o
    ON s.website_session_id = o.website_session_id
WHERE s.created_at < '2013-01-01'
GROUP BY 1,2;
    
-- 2nd analysis will output the same as 1st but by week
SELECT
	MIN(DATE(s.created_at)) AS week_start_date,
    COUNT(DISTINCT s.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders
FROM website_sessions s
    LEFT JOIN orders o
    ON s.website_session_id = o.website_session_id
WHERE s.created_at < '2013-01-01'
GROUP BY
	YEAR(s.created_at),
    WEEK(s.created_at)