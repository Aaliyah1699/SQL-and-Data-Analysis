-- Identify combinations of irrigation and fertilizer type that yield the most
SELECT 
    irrigation_type,
    fertilizer_type,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS sample_count
FROM smart_farming
GROUP BY irrigation_type, fertilizer_type
ORDER BY avg_yield DESC
LIMIT 5;
