-- Underperforming vs. Overperforming Regions

-- Step 1: Calculate average yield per region
WITH regional_yield AS (
    SELECT 
        region,
        ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
    FROM 
        smart_farming
    GROUP BY 
        region
),

-- Step 2: Rank regions by average yield
ranked_regions AS (
    SELECT 
        region,
        avg_yield,
        NTILE(4) OVER (ORDER BY avg_yield) AS yield_quartile
    FROM 
        regional_yield
),

-- Step 3: Label performance groups
region_groups AS (
    SELECT 
        region,
        avg_yield,
        CASE 
            WHEN yield_quartile = 4 THEN 'Overperforming'
            WHEN yield_quartile = 1 THEN 'Underperforming'
            ELSE 'Mid-performing'
        END AS performance_group
    FROM ranked_regions
)

-- Step 4: Aggregate environmental profiles by performance group
SELECT 
    rg.performance_group,
    COUNT(DISTINCT sf.region) AS num_regions,
    ROUND(AVG(temperature_C), 2) AS avg_temp_C,
    ROUND(AVG(rainfall_mm), 2) AS avg_rainfall_mm,
    ROUND(AVG(humidity_pct), 2) AS avg_humidity_pct,
    ROUND(AVG(sunlight_hours), 2) AS avg_sunlight_hrs,
    ROUND(AVG(soil_pH), 2) AS avg_soil_pH,
    ROUND(AVG(NDVI_index), 3) AS avg_ndvi,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield
FROM 
    smart_farming sf
JOIN 
    region_groups rg ON sf.region = rg.region
GROUP BY 
    rg.performance_group
ORDER BY 
    FIELD(performance_group, 'Overperforming', 'Mid-performing', 'Underperforming');
