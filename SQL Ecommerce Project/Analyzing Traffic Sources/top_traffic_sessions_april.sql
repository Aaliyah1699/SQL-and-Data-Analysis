/* Ecommerce Analysis -
Traffic Source Analysis:
Where customer's are coming from & which channels are driving the highest quality traffic
*/

-- Analyzing Top Traffic Sources before April 12, 2012

USE mavenfuzzyfactory;

SELECT utm_source, utm_campaign, http_referer,
	 COUNT(DISTINCT website_session_id) AS sessions 

FROM website_sessions 

WHERE created_at < '2012-04-12' -- Up until April 12, 2012
GROUP BY utm_source, utm_campaign, http_referer  -- Group by date created
ORDER BY sessions DESC;

/*
Summary:
Website Traffic Breakdown (Up Until April 12, 2012)

Top Traffic Source:

The "gsearch - nonbrand" campaign from gsearch.com drove the most traffic with 3,613 sessions.
There are 28 sessions with no source, campaign, or referrer, which could be direct traffic or missing data.
"gsearch - brand" had 26 sessions from gsearch.com and 7 sessions from bsearch.com.
"bsearch - brand" brought in 7 sessions, all from bsearch.com.

Conclusion
Most sessions came from gsearch.com’s nonbrand campaign. Brand campaigns had lower traffic, and some sessions lacked source details.

*/