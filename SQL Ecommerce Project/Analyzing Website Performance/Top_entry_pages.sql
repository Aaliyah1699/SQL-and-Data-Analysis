/*  Ecommerce Analysis -
Analyzing Website Performance:
What pages are seen the most by users and to identify where to focus improving business
*/

-- Analyzing Top entry Pages before June 12, 2012

CREATE TEMPORARY TABLE top_pageview

SELECT 
    pageview_url,
	website_session_id,
    MIN(website_pageview_id) AS pv_id
FROM website_pageviews
WHERE created_at < '2012-06-09' 
GROUP BY website_session_id;

SELECT 
    t2.pageview_url AS landing_page,  -- AKA 'entry page'
    COUNT(DISTINCT t1.website_session_id) AS sessions_hitting_landing
FROM top_pageview t1
	LEFT JOIN website_pageviews t2
    ON t1.pv_id = t2.website_pageview_id
GROUP BY t2.pageview_url
ORDER BY sessions_hitting_landing DESC