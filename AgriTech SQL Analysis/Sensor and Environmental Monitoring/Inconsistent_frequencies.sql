-- Sensors With Inconsistent Frequencies

-- Sensors with very low or very high reading counts
SELECT 
    sensor_id,
    COUNT(*) AS reading_count
FROM 
    smart_farming
GROUP BY 
    sensor_id
HAVING 
    reading_count < 10 OR reading_count > 1000
ORDER BY 
    reading_count;
