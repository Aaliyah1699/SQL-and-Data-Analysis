/*
8. Quantify the impact of our billing test. Analyze
the lift generated frrom the test (sep 10 - nov 10), 
then pull the number of billing sessions for the past
month to understand monthly impact.
*/


SELECT
	billing_version_seen,
	COUNT(DISTINCT website_session_id) AS sessions,
    SUM(price_usd) / COUNT(DISTINCT website_session_id) AS revenue_per_billing_seen
FROM(
SELECT
	p.website_session_id,
    p.pageview_url AS billing_version_seen,
    o.order_id,
    o.price_usd
FROM website_pageviews p
	LEFT JOIN orders o
    ON p.website_session_id = o.website_session_id
WHERE p.created_at > '2012-09-10'
	AND p.created_at < '2012-11-10'
    AND p.pageview_url IN ('/billing', '/billing-2')
) AS billing_pv_and_order_data
GROUP BY 1;

/*
$22.83 per billing page seen for the old version (/billing)
$31.34 for the new version (/billing-2)
LIFT: $8.51 per billing page view
*/

SELECT
	COUNT(website_session_id) AS billing_sess_past_month
FROM website_pageviews
WHERE pageview_url IN ('/billing', '/billing-2')
	AND created_at BETWEEN '2012-10-27' AND '2012-11-27'; -- past month
    
/*
~ 1,194 billing sessions past month
~ LIFT: $8.51 per billing session
~ VALUE OF BILLING TEST: $10,160 over the past month (1,194 * 8.51)
*/