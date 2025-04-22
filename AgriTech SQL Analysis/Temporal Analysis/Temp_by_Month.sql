-- Average temperature by sowing month
SELECT 
    MONTH(sowing_date) AS sowing_month,
    ROUND(AVG(temperature_C), 2) AS avg_temperature_C
FROM smart_farming
GROUP BY sowing_month
ORDER BY sowing_month;
