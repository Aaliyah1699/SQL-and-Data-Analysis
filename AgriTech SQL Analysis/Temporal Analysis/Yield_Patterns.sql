-- Average yield by sowing month
SELECT 
    MONTH(sowing_date) AS sowing_month,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS farm_count
FROM smart_farming
GROUP BY sowing_month
ORDER BY sowing_month;
