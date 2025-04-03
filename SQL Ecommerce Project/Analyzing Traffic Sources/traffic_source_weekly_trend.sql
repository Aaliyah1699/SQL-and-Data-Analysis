/* Ecommerce Analysis -
Traffic Source Analysis:
Where customer's are coming from & which channels are driving the highest quality traffic
*/

-- Traffic Source Trending Analysis

USE mavenfuzzyfactory;

SELECT 
MIN(DATE(created_at)) AS week_start_date,
COUNT(DISTINCT website_session_id) AS sessions
 
FROM website_sessions
WHERE created_at < '2012-05-10'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 
	YEAR(created_at),
    WEEK(created_at)
    

/*
Analysis Summary:
Before the April 15 bid reduction, weekly sessions ranged from 896 to 1,152.

After April 15, sessions dropped significantly:
April 15-21: 621 sessions
April 22-28: 594 sessions
April 29-May 5: 681 sessions
May 6-10: 399 sessions

Conclusion:
The bid reduction on April 15 clearly led to a drop in session volume, with a steady decline through early May.
*/