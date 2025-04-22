-- Count of crop disease occurrences grouped by crop type and region
SELECT 
    crop_type,
    region,
    crop_disease_status,
    COUNT(*) AS disease_cases
FROM smart_farming
WHERE crop_disease_status != 'None'
GROUP BY crop_type, region, crop_disease_status
ORDER BY crop_type, region, crop_disease_status;
