/* Ecommerce Analysis-
Product Analysis.
~ Understand how each product contributes to business, 
and how product launces impact the overall portfollio.
~ Learn how customers interact with each product,
and how well each prroduct converts costumers.
*/

-- Building Product-Level Conversion Funnel

-- STEP 1: select all pageviews for revelant sessions
-- STEP 2: figure out which pageview urls to look for
-- STEP 3: pull all pageviews and identify the funnel steps
-- STEP 4: create the session-level conversion funnel view
-- STEP 5: aggregate the data to assess funnel performance

CREATE TEMPORARY TABLE sessions_seeing_prod_pgs
SELECT
	website_session_id,
    website_pageview_id,
    pageview_url AS prod_pg_seen
FROM website_pageviews
WHERE created_at < '2013-04-13'
	AND created_at > '2013-01-06'
    AND pageview_url IN ('/the-original-mr-fuzzy', '/the-forever-love-bear')
;

SELECT DISTINCT 
	p.pageview_url	
FROM sessions_seeing_prod_pgs s
	LEFT JOIN website_pageviews p
    ON s.website_pageview_id = p.website_pageview_id
    AND p.website_pageview_id > s.website_pageview_id
;

CREATE TEMPORARY TABLE session_prod_level_made_it_flags
SELECT 
	website_session_id,
    CASE 
		WHEN prod_pg_seen = '/the-original-mr-fuzzy' THEN 'mrfuzzy'
        WHEN prod_pg_seen = '/the-forever-love-bear' THEN 'lovebear'
		ELSE 'Check Logic...'
	END AS product_seen,
    MAX(cart_page) AS cart_made_it,              
	MAX(shipping_page) AS shipping_made_it,               
	MAX(billing_page) AS billing_made_it,              
	MAX(thankyou_page) AS thankyou_made_it  
FROM(
SELECT
	s.website_session_id,
    s.prod_pg_seen,
    CASE WHEN p.pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,  -- Flag pages
	CASE WHEN p.pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,  
	CASE WHEN p.pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,  
	CASE WHEN p.pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page  
FROM sessions_seeing_prod_pgs s
	LEFT JOIN website_pageviews p
    ON s.website_session_id = p.website_session_id
	AND p.website_pageview_id > s.website_pageview_id
ORDER BY
	s.website_session_id,
    p.created_at
) AS pageview_level
GROUP BY
	website_session_id,
    CASE 
		WHEN prod_pg_seen = '/the-original-mr-fuzzy' THEN 'mrfuzzy'
        WHEN prod_pg_seen = '/the-forever-love-bear' THEN 'lovebear'
		ELSE 'Check Logic...'
	END
;

SELECT
	product_seen,
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) AS to_cart,
    COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) AS to_shipping,
    COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) AS to_billing,
    COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) AS to_thankyou
FROM session_prod_level_made_it_flags
GROUP BY product_seen
;

SELECT
	product_seen,
    COUNT(DISTINCT website_session_id) AS sessions,
    
    COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END)
		/ COUNT(DISTINCT website_session_id) AS prod_click_rt,
        
    COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) 
		/ COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) AS cart_click_rt,
        
    COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) 
		/ COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) AS shipping_click_rt,
        
	COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) 
		/ COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) AS billing_click_rt
FROM session_prod_level_made_it_flags
GROUP BY product_seen
;
