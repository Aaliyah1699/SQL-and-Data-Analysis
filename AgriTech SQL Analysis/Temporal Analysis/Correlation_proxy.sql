-- Correlation proxy: Average yield by crop growth duration range (binned)
SELECT 
    CASE
        WHEN total_days < 60 THEN 'Under 60 days'
        WHEN total_days BETWEEN 60 AND 89 THEN '60–89 days'
        WHEN total_days BETWEEN 90 AND 119 THEN '90–119 days'
        WHEN total_days >= 120 THEN '120+ days'
    END AS growth_duration_range,
    ROUND(AVG(yield_kg_per_hectare), 2) AS avg_yield,
    COUNT(*) AS record_count
FROM smart_farming
GROUP BY growth_duration_range
ORDER BY FIELD(growth_duration_range, 'Under 60 days', '60–89 days', '90–119 days', '120+ days');
