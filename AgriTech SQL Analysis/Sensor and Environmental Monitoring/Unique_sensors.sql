-- Count of Unique Sensors per Region

-- Count how many distinct IoT sensors are reporting in each region
SELECT 
    region,
    COUNT(DISTINCT sensor_id) AS unique_sensor_count
FROM 
    smart_farming
GROUP BY 
    region
ORDER BY 
    unique_sensor_count DESC;
