-- Frequency of disease (non-'None') by sowing month
SELECT 
    MONTH(sowing_date) AS sowing_month,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN crop_disease_status != 'None' THEN 1 ELSE 0 END) AS disease_cases,
    ROUND(100 * SUM(CASE WHEN crop_disease_status != 'None' THEN 1 ELSE 0 END) / COUNT(*), 2) AS disease_percentage
FROM smart_farming
GROUP BY sowing_month
ORDER BY sowing_month;
