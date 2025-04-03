/*
7. Show a full conversion funnel from each of the two pages to orders
for the previous landing test. Use the same time period (jun 19 - jul 28)
*/

-- Create temporary table with funnel flags per session
CREATE TEMPORARY TABLE flagged_session
SELECT
	website_session_id, -- Unique session ID
	MAX(homepage) AS saw_homepage, -- Flag if session saw /home
	MAX(custom_lander) AS saw_custom_lander, -- Flag if session saw /lander-1
	MAX(products_page) AS product_made_it, -- Flag if session reached /products
	MAX(mrfuzzy_page) AS mrfuzzy_made_it, -- Flag if session reached /the-original-mr-fuzzy
	MAX(cart_page) AS cart_made_it, -- Flag if session reached /cart
	MAX(shipping_page) AS shipping_made_it, -- Flag if session reached /shipping
	MAX(billing_page) AS billing_made_it, -- Flag if session reached /billing
	MAX(thankyou_page) AS thankyou_made_it -- Flag if session reached thank-you page
FROM (
SELECT
	s.website_session_id, -- Session identifier
	p.pageview_url, -- Page URL viewed
	p.created_at AS pageview_created_at, -- Timestamp of the pageview
	CASE WHEN p.pageview_url = '/home' THEN 1 ELSE 0 END AS homepage, -- 1 if URL is /home
	CASE WHEN p.pageview_url = '/lander-1' THEN 1 ELSE 0 END AS custom_lander, -- 1 if URL is /lander-1
	CASE WHEN p.pageview_url = '/products' THEN 1 ELSE 0 END AS products_page, -- 1 if URL is /products
	CASE WHEN p.pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page, -- 1 if URL is /the-original-mr-fuzzy
	CASE WHEN p.pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page, -- 1 if URL is /cart
	CASE WHEN p.pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page, -- 1 if URL is /shipping
	CASE WHEN p.pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page, -- 1 if URL is /billing
	CASE WHEN p.pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page -- 1 if URL is thank-you page
FROM website_sessions s -- Sessions table
	LEFT JOIN website_pageviews p 
		ON s.website_session_id = p.website_session_id -- Join with pageviews
WHERE s.utm_source = 'gsearch' -- Only gsearch sessions
  AND s.created_at < '2012-07-28' -- End of test period
  AND s.created_at > '2012-06-19' -- Start of test period
	
) AS pageview_level
GROUP BY website_session_id; -- Group by session

-- Aggregate conversion counts by landing page segment
SELECT
	CASE
		WHEN saw_homepage = 1 THEN 'saw_homepage'
		WHEN saw_custom_lander = 1 THEN 'saw_custom_lander'
		ELSE 'Uh Oh.. Check Logic'
	END AS segment, -- Label segment based on landing page viewed
	COUNT(DISTINCT website_session_id) AS sessions, -- Count sessions in segment
	COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) AS to_product, -- Sessions reaching /products
	COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS to_mrfuzzy, -- Sessions reaching /the-original-mr-fuzzy
	COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) AS to_cart, -- Sessions reaching /cart
	COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) AS to_ssshipping, -- Sessions reaching /shipping
	COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) AS to_billing, -- Sessions reaching /billing
	COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) AS to_thankyou -- Sessions reaching thank-you page
FROM flagged_session
GROUP BY
	1; -- Group by segment

-- Calculate clickthrough rates at each funnel step by segment
SELECT
	CASE
		WHEN saw_homepage = 1 THEN 'saw_homepage'
		WHEN saw_custom_lander = 1 THEN 'saw_custom_lander'
		ELSE 'Uh Oh.. Check Logic'
	END AS segment, -- Label segment
	COUNT(DISTINCT website_session_id) AS sessions, -- Total sessions in segment
	COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
		/ COUNT(DISTINCT website_session_id) AS lander_clickthrough_rate, -- Rate from landing page to /products
	COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
		/ NULLIF(COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS products_clickthrough_rate, -- Rate from /products to /the-original-mr-fuzzy
	COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
		/ NULLIF(COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS mrfuzzy_clickthrough_rate, -- Rate from /the-original-mr-fuzzy to /cart
	COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
		/ NULLIF(COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS cart_clickthrough_rate, -- Rate from /cart to /shipping
	COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
		/ NULLIF(COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS shipping_clickthrough_rate, -- Rate from /shipping to /billing
	COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) * 1.0
		/ NULLIF(COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END), 0) AS billing_clickthrough_rate -- Rate from /billing to thank-you page
FROM flagged_session
GROUP BY 
	1; -- Group by segment

