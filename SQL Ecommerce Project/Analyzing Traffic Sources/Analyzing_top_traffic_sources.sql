/* Ecommerce Analysis -
Traffic Source Analysis:
Where customer's are coming from & which channels are driving the highest quality traffic
*/

-- Analyzing Top Traffic Sources

USE mavenfuzzyfactory;

SELECT t1.utm_content, 
	COUNT(DISTINCT t1.website_session_id) AS sessions,
    COUNT(DISTINCT t2.order_id) AS orders,
    COUNT(DISTINCT t2.order_id) / COUNT(DISTINCT t1.website_session_id) AS session_to_order_cov_rt -- Analyze conversion rate

FROM website_sessions t1 -- Table 1
	LEFT JOIN orders t2 -- Table 2
		ON t2.website_session_id = t1.website_session_id -- Left join orders table matching ids

WHERE t1.website_session_id BETWEEN 1000 AND 2000 -- arbitrary

GROUP BY 1 -- Group by column 1 (utm_content)
ORDER BY 2 DESC; -- Order: high to low | column 2 (website_session_id AKA sessions)

/* 
Summary:  
Top Traffic Source: The "g_ad_1" campaign generated the highest number of sessions (975) and orders (35) with a conversion rate of 3.59%. This indicates that it is the most effective source in driving high-quality traffic.
Low/No Conversions:
An unnamed source recorded 18 sessions but resulted in 0 orders (0.00% conversion rate).
The "g_ad_2" campaign had 6 sessions with 0 orders (0.00% conversion rate).
The "b_ad_2" campaign had the lowest traffic (2 sessions) and also yielded 0 orders (0.00% conversion rate).
Conclusion
The "g_ad_1" campaign is performing significantly better than the others in terms of traffic volume and conversion rate. The remaining sources, particularly "g_ad_2" and "b_ad_2", are not contributing to conversions and may require further analysis or optimization.
*/