-- Calculate average yield alongside environmental factors for each crop type
SELECT 
    crop_type,
    ROUND(AVG(temperature_C), 2) AS avg_temp_C,
    ROUND(AVG(rainfall_mm), 2) AS avg_rainfall_mm,
    ROUND(AVG(humidity_pct), 2) AS avg_humidity_pct,
    ROUND(AVG(sunlight_hours), 2) AS avg_sunlight_hrs,
    ROUND(AVG(soil_moisture_pct), 2) AS avg_soil_moisture_pct,
    ROUND(AVG(NDVI_index), 3) AS avg_ndvi,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield_kg_per_hectare
FROM 
    smart_farming
GROUP BY 
    crop_type
ORDER BY 
    avg_yield_kg_per_hectare DESC;
