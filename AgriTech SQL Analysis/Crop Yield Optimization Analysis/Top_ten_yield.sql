-- Retrieve the top 10 highest-yielding farms and their relevant growing conditions
SELECT 
    farm_id,
    crop_type,
    region,
    irrigation_type,
    fertilizer_type,
    soil_moisture_pct,
    soil_pH,
    temperature_C,
    rainfall_mm,
    humidity_pct,
    sunlight_hours,
    NDVI_index,
    yield_kg_per_hectare
FROM 
    smart_farming
ORDER BY 
    yield_kg_per_hectare DESC
LIMIT 10;
