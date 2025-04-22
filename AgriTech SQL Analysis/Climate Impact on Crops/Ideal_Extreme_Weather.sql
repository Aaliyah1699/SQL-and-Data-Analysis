-- Yield under ideal vs extreme weather conditions
SELECT 
    crop_type,
    
    CASE
        WHEN temperature_C BETWEEN 20 AND 30
         AND rainfall_mm BETWEEN 100 AND 300
         AND sunlight_hours BETWEEN 4 AND 8
        THEN 'Ideal Conditions'
        ELSE 'Extreme Conditions'
    END AS weather_condition_group,

    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS num_farms
FROM smart_farming
GROUP BY crop_type, weather_condition_group
ORDER BY crop_type, weather_condition_group;
