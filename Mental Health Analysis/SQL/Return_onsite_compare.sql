-- Compare average productivity score
USE remote_workers;

SELECT 
	COUNT(DISTINCT Employee_ID) AS employees,
	AVG(Productivity_Score) AS avg_productivity,
    Willing_To_Return_Onsite
FROM mental_health
GROUP BY Willing_To_Return_Onsite;

/*
Productivity vs. Willingness to Return Onsite
Objective:
To compare average productivity scores for employees willing vs. unwilling to return onsite.

Method:
Grouped employees by Willing_To_Return_Onsite and calculated count and average Productivity_Score.

Key Findings:
Not willing: 46 employees, avg score 5.9
Willing: 54 employees, avg score 6.1
Difference: 0.2 points.

Interpretation:
Productivity is nearly identical between groups, suggesting willingness to return onsite is not strongly tied to productivity.

Recommendation:
Conduct an anonymous survey to understand reasons for reluctance, focusing on commute concerns, flexibility needs, or workplace environment.
*/