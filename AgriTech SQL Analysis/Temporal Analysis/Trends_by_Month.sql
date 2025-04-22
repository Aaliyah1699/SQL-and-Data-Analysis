-- Average NDVI index by sowing month
SELECT 
    MONTH(sowing_date) AS sowing_month,
    ROUND(AVG(NDVI_index), 3) AS avg_NDVI
FROM smart_farming
GROUP BY sowing_month
ORDER BY sowing_month;
