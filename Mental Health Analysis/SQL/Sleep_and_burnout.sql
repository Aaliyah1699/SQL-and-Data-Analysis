-- Identify where low sleep equates to high burnout
USE remote_workers;

SELECT 
	Employee_ID,
    Sleep_Hours_Per_Day,
    Burnout_Score
FROM mental_health
WHERE Sleep_Hours_Per_Day <= 5 AND Burnout_Score > 70
ORDER BY Burnout_Score DESC;

/*
Sleep and Burnout
Objective:
To identify employees with both low sleep (≤5 hours/day) and high burnout (score >70), and assess potential patterns.

Method:
Queried the dataset to filter employees sleeping ≤5 hours per day and with burnout scores above 70. 
	Calculated counts and compared burnout averages between 4-hour and 5-hour sleepers.

Key Findings:
Only 9 employees met both criteria.
Average burnout for 5-hour sleepers: 78.2.
Average burnout for 4-hour sleepers: 75.5.
Lowest sleep in the group: 4 hours/day.

Interpretation:
The very small sample size limits statistical conclusions. Interestingly, employees sleeping exactly 5 hours 
	reported slightly higher burnout than those sleeping 4 hours, suggesting other contributing factors beyond sleep alone.

Recommendation:
Survey these employees to identify additional burnout drivers (e.g., workload, personal stress, health). 
	Use findings to design targeted interventions.
*/