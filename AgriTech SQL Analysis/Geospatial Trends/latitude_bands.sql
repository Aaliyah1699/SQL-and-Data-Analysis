-- Average yield across specific latitude bands
SELECT 
    FLOOR(latitude / 2) * 2 AS lat_band_start,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS farm_count
FROM smart_farming
GROUP BY lat_band_start
ORDER BY avg_yield DESC;
