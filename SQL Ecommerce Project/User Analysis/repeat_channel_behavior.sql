/*Ecommerce Analysis - User Analysis
Objective: 
- Analyze repeat activity to see how often customers
	are coming back and visiting  the site
*/

-- Analyze repeat channel behavior

/* First Query: By UTM Source & Campaign */
SELECT
    utm_source,                     
    utm_campaign,                   
    http_referer,                    -- Referring URL
    COUNT(CASE WHEN is_repeat_session = 0 THEN 1 ELSE NULL END) AS new_sessions,    -- Count new sessions
    COUNT(CASE WHEN is_repeat_session = 1 THEN 1 ELSE NULL END) AS repeat_sessions  -- Count repeat sessions
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-11-05'  -- Filter by date range
GROUP BY utm_source, utm_campaign, http_referer        -- Group by UTM source, campaign, and referer
ORDER BY repeat_sessions DESC;                           -- Order by repeat sessions (high to low)

/* Second Query: By Channel Grouping */
SELECT
    CASE 
        WHEN utm_source IS NULL AND http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com') THEN 'organic_search'
        WHEN utm_campaign = 'nonbrand' THEN 'paid_nonbrand'
        WHEN utm_campaign = 'brand' THEN 'paid_brand'
        WHEN utm_source IS NULL AND http_referer IS NULL THEN 'direct_type_in'
        WHEN utm_source = 'socialbook' THEN 'paid_social'
        ELSE 'other'                                 -- Default group for unclassified sessions
    END AS channel_group,                            -- Create channel group
    COUNT(CASE WHEN is_repeat_session = 0 THEN 1 ELSE NULL END) AS new_sessions,    -- Count new sessions
    COUNT(CASE WHEN is_repeat_session = 1 THEN 1 ELSE NULL END) AS repeat_sessions  -- Count repeat sessions
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-11-05'  -- Filter by date range
GROUP BY channel_group                               -- Group by channel group
ORDER BY repeat_sessions DESC;                       -- Order by repeat sessions (high to low)