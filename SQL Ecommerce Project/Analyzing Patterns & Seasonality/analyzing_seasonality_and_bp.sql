/* Ecommerce Analysis ~
Analyzing Business Patterns and Seasonality.
Generate insightsto help maximize efficiency 
and anticipate future trends.
*/

-- Analyzing Business Patterns and Seasonality
SELECT 
	website_session_id,
    created_at,
    HOUR(created_at) AS hr,
    WEEKDAY(created_at) AS week_day, -- 0 = mon, 1= tues, etc.
    CASE
		WHEN WEEKDAY(created_at) = 3 THEN 'Thursday'
        ELSE 'Other day'
	END AS thurs,
	QUARTER(created_at) AS qtr,
    MONTH(created_at) AS mo,
    DATE(created_at) AS dt,
    WEEK(created_at) AS wk,
    YEAR(created_at) AS yr
FROM website_sessions
WHERE website_session_id BETWEEN 150000 AND 155000 -- arbitrary