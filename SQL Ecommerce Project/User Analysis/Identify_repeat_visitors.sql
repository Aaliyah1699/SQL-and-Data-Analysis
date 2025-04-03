/*Ecommerce Analysis - User Analysis
Objective: 
- Analyze repeat activity to see how often customers
	are coming back and visiting  the site
*/

-- Identifying repeat visiters

-- CTE to identify repeat sessions
WITH sessions_w_repeats AS (
    /* Get first-time sessions and their later repeat sessions */
    SELECT
        ws1.user_id,                             -- User ID
        ws1.website_session_id AS new_session_id,  -- First session ID
        ws2.website_session_id AS repeat_session_id -- Repeat session ID (if exists)
    FROM website_sessions ws1
    LEFT JOIN website_sessions ws2
        ON ws1.user_id = ws2.user_id              -- Match same user
        AND ws2.is_repeat_session = 1             -- Only consider repeat sessions
        AND ws2.website_session_id > ws1.website_session_id  -- Ensure repeat is later
        AND ws2.created_at BETWEEN '2014-01-01' AND '2014-11-01'  -- Date range for repeat
    WHERE ws1.created_at BETWEEN '2014-01-01' AND '2014-11-01'      -- Date range for first session
        AND ws1.is_repeat_session = 0            -- Only first-time sessions
)

-- Aggregate visit frequency per user
SELECT
    repeat_sessions,                           -- Number of repeat sessions per user
    COUNT(user_id) AS users                    -- Count of users with that repeat count
FROM (
    SELECT
        user_id,                             -- User ID
        COUNT(new_session_id) AS new_sessions,       -- Count of new sessions per user
        COUNT(repeat_session_id) AS repeat_sessions   -- Count of repeat sessions per user
    FROM sessions_w_repeats
    GROUP BY user_id                         -- Group by each user
) AS user_level
GROUP BY repeat_sessions                     -- Group by the count of repeat sessions
ORDER BY repeat_sessions DESC;               -- Order from most to least repeats