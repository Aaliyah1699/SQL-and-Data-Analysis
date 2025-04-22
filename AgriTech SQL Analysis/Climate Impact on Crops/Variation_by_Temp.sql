-- Yield variation by temperature, rainfall, and sunlight levels
SELECT 
    crop_type,
    
    -- Temperature Ranges
    CASE 
        WHEN temperature_C < 20 THEN 'Low (<20°C)'
        WHEN temperature_C BETWEEN 20 AND 30 THEN 'Moderate (20-30°C)'
        ELSE 'High (>30°C)'
    END AS temp_range,

    -- Rainfall Ranges
    CASE 
        WHEN rainfall_mm < 100 THEN 'Low (<100mm)'
        WHEN rainfall_mm BETWEEN 100 AND 300 THEN 'Moderate (100-300mm)'
        ELSE 'High (>300mm)'
    END AS rainfall_range,

    -- Sunlight Ranges
    CASE 
        WHEN sunlight_hours < 4 THEN 'Low (<4 hrs)'
        WHEN sunlight_hours BETWEEN 4 AND 8 THEN 'Moderate (4–8 hrs)'
        ELSE 'High (>8 hrs)'
    END AS sunlight_range,

    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
FROM smart_farming
GROUP BY crop_type, temp_range, rainfall_range, sunlight_range
ORDER BY crop_type, temp_range, rainfall_range, sunlight_range;
