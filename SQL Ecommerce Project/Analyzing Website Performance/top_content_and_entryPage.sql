/*  Ecommerce Analysis -
Analyzing Website Performance:
What pages are seen the most by users and to identify where to focus improving business
*/

-- Analyzing Top website pages & Entry pages

USE mavenfuzzyfactory;

-- Top content overall
SELECT 
	pageview_url,
    COUNT(DISTINCT website_pageview_id) AS pvs
FROM website_pageviews

WHERE website_pageview_id < 1000  -- arbitrary

GROUP BY pageview_url
ORDER BY pvs DESC;

-- Top Entry Pages: Using Temporarry Table 

CREATE TEMPORARY TABLE first_pageview

SELECT 
	website_session_id,
    MIN(website_pageview_id) AS min_pv_id
	
FROM website_pageviews
WHERE website_pageview_id < 1000  -- arbitrary

GROUP BY website_session_id;

SELECT 
    t2.pageview_url AS landing_page,  -- AKA 'entry page'
    COUNT(DISTINCT t1.website_session_id) AS sessions_hitting_lander
FROM first_pageview t1

	LEFT JOIN website_pageviews t2
    ON t1.min_pv_id = t2.website_pageview_id
GROUP BY t2.pageview_url

