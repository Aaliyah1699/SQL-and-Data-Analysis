# Mental Health of Remote Workers – Executive Insights Report

## 1. Sleep and Burnout

**Objective:**  
Identify employees with both low sleep (≤5 hours/day) and high burnout (score >70), and assess patterns.

**Method:**  
Filtered employees with ≤5 hours/day sleep and burnout >70. Compared counts and average burnout between 4-hour and 5-hour sleepers.

**Key Findings:**

-   **Count:** 9 employees met both criteria.
-   **Avg burnout:** 5 hours → **78.2** | 4 hours → **75.5**
-   **Minimum sleep in group:** 4 hours/day.

**Interpretation:**  
The small sample (n=9) limits statistical confidence. The higher average burnout among 5-hour sleepers vs 4-hour sleepers suggests additional contributing factors beyond sleep duration.

**Recommendation:**  
Conduct short follow-up surveys or interviews with these employees to identify workload, health, or personal stress drivers and design targeted interventions.

---

## 2. Average Productivity by Work Mode

**Objective:**  
Determine if work mode (Onsite, Remote, Hybrid) impacts productivity.

**Method:**  
Grouped by `Work_Mode` and calculated average `Productivity_Score` (scale: 1–10).

**Key Findings:**

-   **Onsite:** 5.8 / 10
-   **Remote:** 6.0 / 10
-   **Hybrid:** 6.3 / 10
-   **Range:** 0.5 points.

**Interpretation:**  
Productivity is consistent across work modes (difference under 1 point), implying location alone is unlikely to explain meaningful productivity differences.

**Recommendation:**  
Analyze productivity combined with department, workload, and burnout to uncover more influential drivers; prioritize subgroup analysis for high-variance teams.

---

## 3. Top 3 Job Roles by Burnout

**Objective:**  
Identify job roles with the highest average burnout scores.

**Method:**  
Grouped by `Job_Role`, calculated average burnout, and ranked the top three roles.

**Key Findings:**

1. **Product Manager** – 58
2. **UI/UX Designer** – 53
3. **Data Scientist** – 52

-   These roles represent ~12% of the dataset workforce.

**Interpretation:**  
High burnout in these roles likely stems from sustained cognitive load, deadlines, cross-functional coordination, or high autonomy with high responsibility.

**Recommendation:**  
Pilot workload balancing measures: redistribute tasks, add temporary hires during peak cycles, and introduce meeting-free blocks for focused work.

---

## 4. Therapist Access by Country

**Objective:**  
Compare therapist access rates by country.

**Method:**  
Grouped by `Country` and `Has_Access_To_Therapist` and computed % with vs without access.

**Key Findings:**
| Country | With Access | Without Access | Gap (With – Without) |
|-----------|-------------:|---------------:|---------------------:|
| USA | 12% | 9% | +3% |
| UK | 7% | 11% | -4% |
| India | 7% | 4% | +3% |
| Germany | 6% | 8% | -2% |
| Canada | 7% | 2% | +5% (largest gap) |
| Brazil | 8% | 8% | 0% |
| Australia | 5% | 6% | -1% |

**Interpretation:**  
Access is mixed across countries. Canada shows the largest positive gap (more with access), while the UK and Germany have more employees without therapist access than with.

**Recommendation:**  
Pilot mental health benefit expansion (therapy access or subsidy) in a country with a negative gap (e.g., UK). Measure utilization and employee feedback before wider rollout.

---

## 5. Productivity vs. Willingness to Return Onsite

**Objective:**  
Compare average productivity between employees willing and unwilling to return onsite.

**Method:**  
Grouped by `Willing_To_Return_Onsite` and calculated count and average `Productivity_Score`.

**Key Findings:**

-   **Not willing:** 46 employees → **5.9**
-   **Willing:** 54 employees → **6.1**
-   **Difference:** 0.2 points.

**Interpretation:**  
Productivity is nearly identical between groups, suggesting willingness to return onsite is not meaningfully associated with productivity.

**Recommendation:**  
Use an anonymous survey to identify reasons for reluctance (commute, flexibility, health, caregiving); address addressable concerns (policy, workplace environment) where feasible.

---

## 6. Internet Issues Frequency (Remote Workers)

**Objective:**  
Measure frequency of internet issues among remote workers.

**Method:**  
Filtered `Work_Mode = Remote` and counted by `Internet_Issues_Frequency`.

**Key Findings:**

-   **Sometimes:** 19 employees
-   **Never:** 14 employees
-   **Often:** 8 employees

**Interpretation:**  
Most remote colleagues report infrequent connectivity issues, though a non-trivial minority experiences frequent disruptions that can affect productivity.

**Recommendation:**  
Identify employees with frequent issues for targeted remediation (equipment check, ISP support, stipend for higher-tier service). Consider tracking issue resolution outcomes.

---

## 7. Mental Health Status by Country

**Objective:**  
Identify the most common mental health status per country.

**Method:**  
Grouped by `Country` and `Mental_Health_Status`, counted employees, and identified top status per country.

**Key Findings:**

-   **USA:** Most common = _Moderate_ (10 employees)
-   **UK:** Most common = _Poor_ (8 employees)
-   **Brazil:** Most common = _Moderate_ (7 employees)

**Interpretation:**  
Moderate-to-poor mental health is prevalent across regions, signaling potential systemic factors (workload, lack of resources, external stressors).

**Recommendation:**  
Pilot mental health programs (paid mental health days, therapy coverage) in countries with higher poor ratings; collect utilization and outcome metrics.

---

## 8. Experience vs. Burnout

**Objective:**  
Assess whether years of experience are associated with higher burnout scores.

**Method:**  
Extracted the top 10 burnout scores and recorded corresponding years of experience to identify patterns.

**Key Findings (Experience → Burnout):**
| Experience (yrs) | Burnout Score |
|------------------:|--------------:|
| 19 | 85 |
| 17 | 81 |
| 14 | 87 |
| 10 | 87 |
| 6 | 84 |
| 6 | 81 |
| 5 | 85 |
| 3 | 83 |
| 2 | 87 |
| 2 | 83 |

**Interpretation:**  
High burnout appears across both low- and high-experience employees. This pattern indicates burnout is not limited to senior staff, and early-career employees are also at risk.

**Recommendation:**  
Prioritize interviews or short surveys for employees with <5 years experience who display high burnout to identify early-career stressors (onboarding gaps, role clarity, workload). Combine qualitative insights with quantitative tracking for targeted remediation.

---

**Notes & Limitations:**

-   Several analyses have small subgroup sample sizes; treat conclusions as exploratory and follow up with targeted surveys or larger samples where possible.
-   Burnout and mental health measures are self-reported and subject to bias. Where feasible, combine with objective signals (time-off, task completion metrics) for triangulation.
