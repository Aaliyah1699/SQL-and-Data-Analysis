-- Regions with Highest Yields and Their Conditions

-- Identify top performing regions and their average growing conditions
WITH region_avg_yield AS (
    SELECT 
        region,
        ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
    FROM 
        smart_farming
    GROUP BY 
        region
)

SELECT 
    sf.region,
    ray.avg_yield,
    ROUND(AVG(temperature_C), 2) AS avg_temp_C,
    ROUND(AVG(rainfall_mm), 2) AS avg_rainfall_mm,
    ROUND(AVG(humidity_pct), 2) AS avg_humidity_pct,
    ROUND(AVG(sunlight_hours), 2) AS avg_sunlight_hrs,
    ROUND(AVG(soil_moisture_pct), 2) AS avg_soil_moisture_pct,
    ROUND(AVG(soil_pH), 2) AS avg_soil_pH,
    ROUND(AVG(NDVI_index), 3) AS avg_ndvi
FROM 
    smart_farming sf
JOIN 
    region_avg_yield ray ON sf.region = ray.region
WHERE 
    ray.avg_yield = (SELECT MAX(avg_yield) FROM region_avg_yield)
GROUP BY 
    sf.region, ray.avg_yield;
