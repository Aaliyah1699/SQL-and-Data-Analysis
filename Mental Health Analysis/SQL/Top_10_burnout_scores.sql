-- Top 10 burnout scores by experience
use remote_workers;

SELECT 
	Experience_Years, 
	Burnout_Score
FROM mental_health
ORDER BY Burnout_Score DESC
LIMIT 10;

/*
Experience Years vs. Burnout Score
Objective:
To determine whether more experienced employees have higher burnout scores.

Method:
Retrieved top 10 burnout scores and matched them with years of experience.

Key Findings:
Experience (yrs) → Burnout Score:
19 → 85
17 → 81
14 → 87
10 → 87
6 → 84, 81
5 → 85
3 → 83
2 → 87, 83

Interpretation:
Both highly experienced and less experienced employees appear among the highest burnout scores, 
	indicating burnout is not exclusive to senior staff.

Recommendation:
Interview employees with <5 years of experience and high burnout to understand early-career stressors and develop targeted support measures.
*/