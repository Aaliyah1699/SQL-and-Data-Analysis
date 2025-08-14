-- Employees with access to therapist by country
USE remote_workers;

SELECT 
	(COUNT(Employee_ID) * 100) / SUM(COUNT(Employee_ID)) OVER() AS employee_percentage,
    Country,
    Has_Access_To_Therapist
FROM mental_health
GROUP BY 2, 3
ORDER BY Country DESC;

/*
Therapist Access by Country
Objective:
To find the percentage of employees with and without therapist access, grouped by country.

Method:
Grouped employees by Country and therapist access (Yes/No), then calculated percentages and differences.

Key Findings:
Country, With Access, Without Access, Gap (With – Without)
USA, 12%, 9%, +3%
UK,	7%,	11%, -4%
India,	7%,	4%,	+3%
Germany, 6%, 8%, -2%
Canada,	7%,	2%,	+5% (largest gap)
Brazil,	8%,	8%,	0%
Australia,	5%,	6%,	-1%

Interpretation:
Access to therapists is generally balanced across countries, but Canada shows the largest positive gap (+5%), 
	while the UK and Germany have more employees without access than with.

Recommendation:
Pilot a mental health benefit expansion in the UK (largest negative gap) to assess adoption and impact, 
	then scale globally if results are positive.
*/