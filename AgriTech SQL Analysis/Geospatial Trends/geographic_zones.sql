-- Yield averages for geographic zones (latitude and longitude grids)
SELECT 
    CONCAT(FLOOR(latitude / 2) * 2, ' to ', FLOOR(latitude / 2) * 2 + 2) AS latitude_zone,
    CONCAT(FLOOR(longitude / 2) * 2, ' to ', FLOOR(longitude / 2) * 2 + 2) AS longitude_zone,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS farm_count
FROM smart_farming
GROUP BY latitude_zone, longitude_zone
ORDER BY latitude_zone, longitude_zone;
