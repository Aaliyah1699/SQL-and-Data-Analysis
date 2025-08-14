-- Count of remote workers with internet issues
USE remote_workers;

SELECT
	COUNT(DISTINCT Employee_ID) AS employees,
    Internet_Issues_Frequency,
    Work_Mode
FROM mental_health
WHERE Work_Mode = 'Remote'
GROUP BY Internet_Issues_Frequency;

/*
Internet Issues Frequency (Remote Workers)
Objective:
To analyze how frequently remote employees experience internet issues.

Method:
Filtered for Work_Mode = Remote, counted employees, and grouped by Internet_Issues_Frequency.

Key Findings:
Sometimes: 19 employees
Never: 14 employees
Often: 8 employees

Interpretation:
Most remote employees rarely experience connectivity issues, though a minority report frequent disruptions.

Recommendation:
Identify employees with recurring issues and assess whether the root cause is equipment, service provider, or location-related. 
	Consider providing internet stipends or upgraded equipment.
*/