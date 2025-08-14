-- Count of employees by country and mental health status
USE remote_workers;

SELECT
	COUNT(DISTINCT Employee_ID) as employees,
    Mental_Health_Status,
    Country
FROM mental_health
GROUP BY 2, 3
ORDER BY employees DESC;

/*
Mental Health Status by Country
Objective:
To count employees by mental health status within each country.

Method:
Grouped employees by Country and Mental_Health_Status, counted employees, and identified the most common status per country.

Key Findings:
USA: Most common = Moderate (10 employees)
UK: Most common = Poor (8 employees)
Brazil: Most common = Moderate (7 employees)

Interpretation:
Moderate to poor mental health is the most common status across major regions, suggesting potential systemic factors impacting well-being.

Recommendation:
Pilot a mental health benefit that includes paid mental health days and therapy coverage in one country with 
	higher poor ratings (e.g., UK), then expand based on outcomes.
*/