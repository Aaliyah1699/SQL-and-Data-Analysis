-- Frequency of Readings per Sensor

-- Count how many data snapshots each sensor has recorded
SELECT 
    sensor_id,
    COUNT(*) AS reading_count,
    MIN(timestamp) AS first_reading,
    MAX(timestamp) AS last_reading
FROM 
    smart_farming
GROUP BY 
    sensor_id
ORDER BY 
    reading_count DESC;
