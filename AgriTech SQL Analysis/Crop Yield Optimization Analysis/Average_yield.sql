USE agritech;

-- Get average crop yield grouped by crop type, region, and irrigation type
SELECT 
    crop_type,
    region,
    irrigation_type,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield_kg_per_hectare
FROM 
    smart_farming
GROUP BY 
    crop_type, region, irrigation_type
ORDER BY 
    crop_type, region, irrigation_type;
