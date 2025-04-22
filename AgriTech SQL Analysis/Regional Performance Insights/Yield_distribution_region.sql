-- Yield Distribution by Region (average, min, max)

-- Analyze the yield spread (min, max, avg) for each region
SELECT 
    region,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    MIN(yield_kg_per_hectare) AS min_yield,
    MAX(yield_kg_per_hectare) AS max_yield
FROM 
    smart_farming
GROUP BY 
    region
ORDER BY 
    avg_yield DESC;
