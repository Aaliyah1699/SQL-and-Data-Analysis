-- Yield comparison based on soil pH and NDVI index
SELECT 
    crop_type,

    -- Soil pH categories
    CASE
        WHEN soil_pH < 5.5 THEN 'Acidic (<5.5)'
        WHEN soil_pH BETWEEN 5.5 AND 7.5 THEN 'Neutral (5.5–7.5)'
        ELSE 'Alkaline (>7.5)'
    END AS pH_category,

    -- NDVI ranges
    CASE
        WHEN NDVI_index < 0.4 THEN 'Low Vegetation (<0.4)'
        WHEN NDVI_index BETWEEN 0.4 AND 0.7 THEN 'Moderate (0.4–0.7)'
        ELSE 'High Vegetation (>0.7)'
    END AS ndvi_category,

    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
FROM smart_farming
GROUP BY crop_type, pH_category, ndvi_category
ORDER BY crop_type, pH_category, ndvi_category;
