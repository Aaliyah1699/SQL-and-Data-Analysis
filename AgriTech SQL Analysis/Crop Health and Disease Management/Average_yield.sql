-- Average yield grouped by crop disease status
SELECT 
    crop_disease_status,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS record_count
FROM smart_farming
GROUP BY crop_disease_status
ORDER BY 
    CASE crop_disease_status
        WHEN 'None' THEN 1
        WHEN 'Mild' THEN 2
        WHEN 'Moderate' THEN 3
        WHEN 'Severe' THEN 4
        ELSE 5
    END;
