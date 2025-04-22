-- Average pesticide use by crop type and disease status
SELECT 
    crop_type,
    crop_disease_status,
    ROUND(AVG(pesticide_usage_ml), 2) AS avg_pesticide_ml,
    COUNT(*) AS record_count
FROM smart_farming
GROUP BY crop_type, crop_disease_status
ORDER BY crop_type, 
    CASE crop_disease_status
        WHEN 'None' THEN 1
        WHEN 'Mild' THEN 2
        WHEN 'Moderate' THEN 3
        WHEN 'Severe' THEN 4
        ELSE 5
    END;
