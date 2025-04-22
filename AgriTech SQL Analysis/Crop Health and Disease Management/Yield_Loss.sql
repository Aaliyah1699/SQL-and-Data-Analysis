-- Estimate yield loss for Moderate or Severe disease status
SELECT 
    'Healthy (No Disease)' AS disease_group,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
FROM smart_farming
WHERE crop_disease_status = 'None'

UNION ALL

SELECT 
    'Diseased (Moderate/Severe)' AS disease_group,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
FROM smart_farming
WHERE crop_disease_status IN ('Moderate', 'Severe');
