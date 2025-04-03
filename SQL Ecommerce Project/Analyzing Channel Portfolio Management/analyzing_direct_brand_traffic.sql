/* Ecommerce Analysis-
Analysis for Channel Portfolio Management.
Channel portfolio optimization.
*/

-- Analyzing direct traffic

SELECT 
    CASE 
		WHEN http_referer IS NULL THEN 'direct_type_in'
        WHEN http_referer = 'https://www.gsearch.com' AND utm_source IS NULL THEN 'gsearch_organic'
        WHEN http_referer = 'https://www.bsearch.com' AND utm_source IS NULL THEN 'bsearch_organic'
        ELSE 'other'
	END,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 AND 115000 -- arbitrary
	AND utm_source IS NULL -- remove paid traffic parameters
GROUP BY 1
ORDER BY 2 DESC;
    