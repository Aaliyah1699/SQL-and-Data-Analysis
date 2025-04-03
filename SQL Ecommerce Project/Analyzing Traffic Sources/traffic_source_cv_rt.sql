/* Ecommerce Analysis -
Traffic Source Analysis:
Where customer's are coming from & which channels are driving the highest quality traffic
*/

/*
understand if gsearch nonbrand is driving sales. The conversion rate should be 4% or more to make the numbers work. If it's
lower that 4% reduce bids, if its over 4% increase bids to drive more volume
*/

-- Traffic Source Conversion Rates

USE mavenfuzzyfactory;

SELECT 
	COUNT(DISTINCT t1.website_session_id) AS sessions,
    COUNT(DISTINCT t2.order_id) AS orders,
    COUNT(DISTINCT t2.order_id) / COUNT(DISTINCT t1.website_session_id) AS session_to_order_cov_rt -- Analyze conversion rate

FROM website_sessions t1 -- Table 1
	LEFT JOIN orders t2 -- Table 2
		ON t2.website_session_id = t1.website_session_id -- Left join orders table matching ids

WHERE t1.created_at < '2012-04-14' -- Up until April 14, 2012
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'

/*
Summary:

Gsearch Nonbrand Sales Performance (Up to April 14, 2012)
Total Sessions: 3,895
Total Orders: 112
Conversion Rate: 2.88%
Conclusion
The conversion rate is below the 4% target (2.88%). This means the campaign is underperforming, 
and bid reductions are necessary to optimize costs.
*/