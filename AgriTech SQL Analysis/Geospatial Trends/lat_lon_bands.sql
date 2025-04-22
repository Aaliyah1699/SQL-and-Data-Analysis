-- Grouping farms by latitude and longitude bands to analyze yield by region
SELECT 
    FLOOR(latitude / 2) * 2 AS lat_band_start,
    FLOOR(longitude / 2) * 2 AS long_band_start,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS farm_count
FROM smart_farming
GROUP BY lat_band_start, long_band_start
ORDER BY lat_band_start, long_band_start;
