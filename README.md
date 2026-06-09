# Bellabeat Case Study — Smart Device Usage Analysis

## Introduction

This case study was completed as part of the Google Data Analytics Professional Certificate. 

I analyzed FitBit fitness tracker data to identify trends in smart device usage and provide marketing recommendations for Bellabeat, a high-tech wellness company focused on women's health. The product selected for this analysis is the Bellabeat Leaf which is a wellness tracker that monitors activity, sleep, and stress.

---

## Business Task

Analyze smart device usage data to identify consumer behavior trends and apply these insights to inform Bellabeat's marketing strategy for the Leaf product.

**Key questions:**
1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat's marketing strategy?

**Stakeholders:**
- Urška Sršen — Co-founder and Chief Creative Officer
- Sando Mur — Co-founder and Executive Team Member
- Bellabeat Marketing Analytics Team

---

## Data Sources

**Dataset:** [FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit) (CC0: Public Domain, via Kaggle/Mobius)

- Around 30 FitBit users who consented to share personal tracker data
- Data collected between March 2016 and May 2016
- Two folders combined: `Fitabase Data 3.12.16-4.11.16` and `Fitabase Data 4.12.16-5.12.16`

**Tables used:**
| Table | Description |
|---|---|
| `dailyActivity` | Daily steps, distance, calories, active minutes |
| `sleepDay` | Sleep duration and time in bed |
| `hourlySteps` | Steps per hour of the day |
| `weightLogInfo` | Weight and BMI logs |

**Limitations:**
- Small sample size (~30 users) - not statistically representative
- No demographic data (age, gender) - can't confirm all users are women
- Data from 2016 - behavior patterns may have changed
- Short time period (2 months)

---

## Tools Used

- **BigQuery (SQL)** — Data cleaning, transformation and analysis
- **Tableau Public** — Data visualization and dashboard
- **GitHub** — Portfolio and documentation

---

## Process — Data Cleaning

All data was imported into BigQuery and cleaned using SQL.

**Steps taken:**
- Merged the two folders using `UNION ALL` for `dailyActivity`, `hourlySteps`, and `weightLogInfo`
- Removed duplicates using `SELECT DISTINCT`
- Converted date columns from STRING to DATE/DATETIME using `PARSE_DATE` and `PARSE_DATETIME`
- Excluded rows where `TotalSteps = 0` (inactive days)
- Removed duplicate entries in `sleepDay`

---

## Analysis & Key Findings

### 1. Users are not reaching the recommended daily step goal
The average number of steps per day across all users is 8,079 steps which is below the WHO recommendation of 10,000 steps/day. No user consistently reaches this goal on average.

### 2. Peak activity hours are at 12pm and 6–7pm
Analysis of hourly step data shows two clear activity peaks during the day, around noon and between 6pm and 7pm. Likely corresponding to lunch breaks and after-work activity.

### 3. Saturday is the most active day of the week
Users walk the most on Saturdays, while Sundays are the least active day. Weekday activity is relatively consistent around 8,000 steps.

### 4. 54% of users don't get enough sleep
Out of 24 users who tracked their sleep, 13 (54%) average less than 7 hours of sleep per night, below the recommended 7–9 hours.

### 5. Weight tracking is significantly underused
Only 13 out of 33 users (39%) logged their weight, compared to 33 who tracked activity and 24 who tracked sleep. This suggests the weight tracking feature has low adoption.

### 6. Moderate correlation between steps and calories
A correlation coefficient of 0.56 was found between total daily steps and calories burned, confirming that more active users burn more calories, but other factors (like BMI and activity intensity) also play a role.

---

## Dashboard

[Link to the dashboard](https://public.tableau.com/app/profile/bruno.branco.garcia/viz/StudyCase_17809380921690/Tableaudebord1)

The dashboard includes:
- Average Steps per Hour of the Day
- Average Steps per Day of the Week
- Average Active Minutes by Day of the Week
- Sleep Enough vs Not Enough (Pie Chart)
- Tracking Adoption (Activity vs Sleep vs Weight)

---

## Recommendations

### Recommendation 1 : Smart Notifications Based on User Behavior
Based on: Peak activity at 12pm and 6–7pm / No user reaches 10,000 steps/day

Bellabeat should implement personalized push notifications in the app timed to when users are already active. For example, the Leaf could vibrate at 5:30pm if the user hasn't yet reached 70% of their daily step goal. This leverages existing behavior patterns to nudge users toward healthier habits.

Marketing angle: Highlight this feature in Google Search and Instagram ads targeting active women aged 25–40.

---

### Recommendation 2 : Build a Sleep-Focused Marketing Campaign
Based on: 54% of users sleep less than 7 hours per night

Sleep is an underserved angle in the wearables market, most competitors focus on physical activity. Bellabeat should position the Leaf as a sleep wellness device and build campaigns around recovery and rest. This is a strong differentiator, especially for women juggling work, family, and personal health.

Marketing angle : Run video ads on YouTube and display ads on Google targeting women searching for sleep improvement solutions. Feature sleep insights prominently in the Bellabeat app onboarding.

---

### Recommendation 3 : Gamify and Simplify Weight Tracking to Drive Membership
Based on: Only 13 users track their weight, lowest adoption of all features

The low adoption of weight tracking represents a missed engagement opportunity. Bellabeat should simplify the weight logging experience (for example : integration with smart scales, gentle weekly reminders) and use it as an entry point to promote the Bellabeat Membership, which offers personalized nutrition and wellness guidance.

Marketing angle: Position the membership as the complete health solution that connects activity, sleep, and weight in one place. Offer a free trial triggered when users first log their weight.

---

## Limitations & Next Steps

- A larger and more recent dataset would improve the reliability of these findings
- Adding demographic data (age, gender, location) would allow more targeted recommendations
- Tracking app engagement data (notification open rates, feature usage) would help measure the impact of the proposed recommendations
- A survey of current Bellabeat users could validate whether these FitBit trends apply to Bellabeat's specific customer base

---

## Author

Bruno Branco Garcia  
Google Data Analytics Professional Certificate — Case Study 2  
[LinkedIn](https://www.linkedin.com/in/bruno-branco-778211254/) | [Tableau Public](https://public.tableau.com/app/profile/bruno.branco.garcia/vizzes)