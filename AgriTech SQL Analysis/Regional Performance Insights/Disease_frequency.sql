-- Disease Frequency by Region and Correlation with Yield

-- Calculate disease status frequency and average yield per region
SELECT 
    region,
    crop_disease_status,
    COUNT(*) AS disease_count,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
FROM 
    smart_farming
GROUP BY 
    region, crop_disease_status
ORDER BY 
    region, disease_count DESC;
