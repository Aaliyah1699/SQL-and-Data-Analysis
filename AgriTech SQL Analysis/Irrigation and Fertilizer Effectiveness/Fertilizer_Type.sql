-- Average crop yield grouped by fertilizer type
SELECT 
    fertilizer_type,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS sample_size
FROM smart_farming
GROUP BY fertilizer_type
ORDER BY avg_yield DESC;
