-- Identify Sensors with Abnormal or Inconsistent Data (*None found)

-- Identify sensors that report environmental values outside realistic decimal thresholds
SELECT 
    sensor_id,
    farm_id,
    region,
    timestamp,
    temperature_C,
    soil_moisture_pct,
    humidity_pct,
    NDVI_index,
    crop_disease_status
FROM 
    smart_farming
WHERE 
    -- Temperature in °C: Valid range assumed to be between -5.0 and 50.0 (1 decimal precision)
    temperature_C NOT BETWEEN -5.0 AND 50.0
    
    -- Soil Moisture in %: Valid range 0.0% to 100.0% (1 or 2 decimal precision)
    OR soil_moisture_pct NOT BETWEEN 0.0 AND 100.0
    
    -- Humidity in %: Valid range 0.0% to 100.0% (1 decimal)
    OR humidity_pct NOT BETWEEN 0.0 AND 100.0
    
    -- NDVI index: Valid range 0.30 to 0.90 (2 decimal precision, vegetation health)
    OR NDVI_index NOT BETWEEN 0.30 AND 0.90
ORDER BY 
    timestamp;
    

-- Temperature Range
SELECT MIN(temperature_C) AS min_temp, MAX(temperature_C) AS max_temp FROM smart_farming;

-- Soil Moisture Range
SELECT MIN(soil_moisture_pct) AS min_moisture, MAX(soil_moisture_pct) AS max_moisture FROM smart_farming;

-- Humidity Range
SELECT MIN(humidity_pct) AS min_humidity, MAX(humidity_pct) AS max_humidity FROM smart_farming;

-- NDVI Index Range
SELECT MIN(NDVI_index) AS min_ndvi, MAX(NDVI_index) AS max_ndvi FROM smart_farming;


