-- Yield by latitude and longitude zones for heatmap visualization
SELECT 
    FLOOR(latitude / 5) * 5 AS lat_zone_start,
    FLOOR(longitude / 5) * 5 AS long_zone_start,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
FROM smart_farming
GROUP BY lat_zone_start, long_zone_start
ORDER BY avg_yield DESC;
