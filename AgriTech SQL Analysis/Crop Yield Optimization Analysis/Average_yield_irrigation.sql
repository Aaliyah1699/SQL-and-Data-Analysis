-- Breakdown of average yield by crop type and irrigation method
SELECT 
    crop_type,
    irrigation_type,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
FROM 
    smart_farming
GROUP BY 
    crop_type, irrigation_type
ORDER BY 
    crop_type, avg_yield DESC;
