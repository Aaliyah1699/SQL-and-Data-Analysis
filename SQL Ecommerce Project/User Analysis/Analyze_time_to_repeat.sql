/*Ecommerce Analysis - User Analysis
Objective: 
- Analyze repeat activity to see how often customers
	are coming back and visiting  the site
*/

-- Analyze time to repeat

WITH sessions_w_repeats AS (
    /* Get first sessions and their matching repeats */
    SELECT
        ws1.user_id,                             -- User ID
        ws1.website_session_id AS new_session_id,  -- First session ID
        ws1.created_at AS new_session_created_at,  -- First session timestamp
        ws2.website_session_id AS repeat_session_id,  -- Repeat session ID
        ws2.created_at AS repeat_session_created_at  -- Repeat session timestamp
    FROM website_sessions ws1
    LEFT JOIN website_sessions ws2
        ON ws1.user_id = ws2.user_id             -- Same user
        AND ws2.is_repeat_session = 1            -- Only repeat sessions
        AND ws2.website_session_id > ws1.website_session_id  -- Repeat after first
        AND ws2.created_at BETWEEN '2014-01-01' AND '2014-11-03'  -- Repeat within date range
    WHERE ws1.created_at BETWEEN '2014-01-01' AND '2014-11-03'  -- First session in date range
        AND ws1.is_repeat_session = 0            -- Only new sessions
), 

users_first_to_second AS (
    /* Compute days to first repeat */
    SELECT
        user_id,  -- User ID
        TIMESTAMPDIFF(DAY, new_session_created_at, MIN(repeat_session_created_at)) AS days_first_to_second_session  -- Days until first repeat
    FROM sessions_w_repeats
    WHERE repeat_session_id IS NOT NULL         -- Only if a repeat exists
    GROUP BY user_id, new_session_created_at     -- Group by user and first session time
)

-- Get summary statistics
SELECT
    AVG(days_first_to_second_session) AS avg_days_first_to_second,  -- Average days to repeat
    MIN(days_first_to_second_session) AS min_days_first_to_second,  -- Minimum days to repeat
    MAX(days_first_to_second_session) AS max_days_first_to_second   -- Maximum days to repeat
FROM users_first_to_second;
