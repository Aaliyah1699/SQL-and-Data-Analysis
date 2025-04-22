-- Average daily pesticide usage grouped by disease severity
SELECT 
    crop_disease_status,
    ROUND(AVG(pesticide_usage_ml), 2) AS avg_daily_pesticide_ml,
    COUNT(*) AS sample_count
FROM smart_farming
WHERE crop_disease_status IS NOT NULL
GROUP BY crop_disease_status
ORDER BY 
    CASE crop_disease_status
        WHEN 'None' THEN 1
        WHEN 'Mild' THEN 2
        WHEN 'Moderate' THEN 3
        WHEN 'Severe' THEN 4
        ELSE 5
    END;
