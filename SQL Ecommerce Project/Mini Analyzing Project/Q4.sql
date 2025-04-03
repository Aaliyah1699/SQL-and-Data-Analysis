/*
4. Pull monthly trends for gsearch and each of the other channels (gsearch, bsearch, nonbrand, brand)
 * null = organic search traffic *
*/
    
-- Get distinct values for utm_source, utm_campaign, and http_referer
SELECT DISTINCT
	utm_source, -- traffic source (e.g., gsearch, bsearch)
	utm_campaign, -- campaign type (e.g., brand, nonbrand)
	http_referer -- referral URL
FROM website_sessions
WHERE created_at < '2012-11-27'; -- filter sessions before the date

-- Pull monthly trends for different channels
SELECT 
	YEAR(w.created_at) AS year, -- extract year from created_at
	MONTH(w.created_at) AS month, -- extract month from created_at
	COUNT(DISTINCT CASE WHEN w.utm_source = 'gsearch' THEN w.website_session_id ELSE NULL END) AS gsearch_paid_sessions, -- sessions from gsearch
	COUNT(DISTINCT CASE WHEN w.utm_source = 'bsearch' THEN w.website_session_id ELSE NULL END) AS bsearch_paid_sessions, -- sessions from bsearch
	COUNT(DISTINCT CASE WHEN w.utm_source IS NULL AND w.http_referer IS NOT NULL THEN w.website_session_id ELSE NULL END) AS organic_search_sessions, -- sessions from organic search
	COUNT(DISTINCT CASE WHEN w.utm_source IS NULL AND w.http_referer IS NULL THEN w.website_session_id ELSE NULL END) AS direct_type_in_sessions -- sessions from direct type-in traffic
FROM website_sessions w
WHERE w.created_at < '2012-11-27' -- filter sessions before the date
GROUP BY 
	1,2; -- group results by year and month
