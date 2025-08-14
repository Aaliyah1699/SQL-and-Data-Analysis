-- Top 3 jobs with highest burnout
USE remote_workers;

SELECT 
	Job_Role,
    AVG(Burnout_Score) AS burnout_score
FROM mental_health
GROUP BY Job_Role
ORDER BY burnout_score DESC
LIMIT 3;

/*
Top 3 Job Roles by Burnout Score
Objective:
To identify the job roles with the highest average burnout scores.

Method:
Grouped employees by Job_Role, calculated average burnout score for each, and ranked top 3.

Key Findings:
Product Manager: 58/100
UI/UX Designer: 53/100
Data Scientist: 52/100
These roles represent 12% of the workforce in the dataset.

Interpretation:
High-scoring roles are likely under sustained workload pressure, possibly due to tight deadlines, 
	cross-team dependencies, or complex project requirements.

Recommendation:
Pilot workload balancing measures in these roles, such as redistributing projects, 
	adding interim hires, or introducing “focus days” with no meetings.
*/