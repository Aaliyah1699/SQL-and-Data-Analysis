-- Average productivity
USE remote_workers;

SELECT 
	AVG(Productivity_Score) as avg_productivity, 
    Work_Mode
FROM mental_health
GROUP BY 2;

/*
Average Productivity by Work Mode
Objective:
To determine if employee work mode (Onsite, Remote, Hybrid) influences productivity.

Method:
Grouped employees by Work_Mode and calculated the average Productivity_Score (scale: 1–10).

Key Findings:
Onsite: 5.8/10
Remote: 6.0/10
Hybrid: 6.3/10
Range between highest and lowest: 0.5 points.

Interpretation:
Productivity levels are similar across work modes, with differences under one point, 
	indicating location alone may not significantly impact performance.

Recommendation:
Analyze productivity in combination with other factors such as department, workload, 
	and burnout to identify more influential drivers.
*/