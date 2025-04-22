-- Soil moisture vs yield across crop types
SELECT 
    crop_type,

    CASE 
        WHEN soil_moisture_pct < 15 THEN 'Low (<15%)'
        WHEN soil_moisture_pct BETWEEN 15 AND 30 THEN 'Moderate (15–30%)'
        ELSE 'High (>30%)'
    END AS moisture_level,

    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS sample_size
FROM smart_farming
GROUP BY crop_type, moisture_level
ORDER BY crop_type, moisture_level;
