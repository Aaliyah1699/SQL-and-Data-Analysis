/* Ecommerce Analysis ~
Analyzing Business Patterns and Seasonality.
Generate insightsto help maximize efficiency 
and anticipate future trends.
*/

-- Analyzing Business Patterns 
	-- by each hour of day and day of week
SELECT
	hr, 	
	ROUND(AVG(CASE WHEN wkday = 0 THEN sessions ELSE NULL END), 1)  AS Mon,
    ROUND(AVG(CASE WHEN wkday = 1 THEN sessions ELSE NULL END), 1)  AS Tues,
    ROUND(AVG(CASE WHEN wkday = 2 THEN sessions ELSE NULL END), 1)  AS Wed,
    ROUND(AVG(CASE WHEN wkday = 3 THEN sessions ELSE NULL END), 1)  AS Thurs,
    ROUND(AVG(CASE WHEN wkday = 4 THEN sessions ELSE NULL END), 1)  AS Fri,
    ROUND(AVG(CASE WHEN wkday = 5 THEN sessions ELSE NULL END), 1)  AS Sat,
    ROUND(AVG(CASE WHEN wkday = 6 THEN sessions ELSE NULL END), 1)  AS Sun

FROM(
SELECT
	HOUR(created_at) AS hr,
    WEEKDAY(created_at) AS wkday,
    DATE(created_at) AS created_date,
	COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-09-15' AND '2012-11-15'
GROUP BY 1, 2, 3
) AS session_day_hour
GROUP BY 1