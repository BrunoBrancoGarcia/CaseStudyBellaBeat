-- Merge daily_activity from the two datasets from 3.12.16-4.11.16 and 4.12.16-5.12.16
CREATE OR REPLACE TABLE `newproject-496511.BellaBeatCaseStudy.daily_activity` AS
SELECT DISTINCT * FROM (
  SELECT * FROM `newproject-496511.BellaBeatCaseStudy.dailyActivity1`
  UNION ALL
  SELECT * FROM `newproject-496511.BellaBeatCaseStudy.dailyActivity2`
);

-- Merge hourly_steps from the two datasets from 3.12.16-4.11.16 and 4.12.16-5.12.16
CREATE OR REPLACE TABLE `newproject-496511.BellaBeatCaseStudy.hourly_steps` AS
SELECT DISTINCT * FROM (
  SELECT * FROM `newproject-496511.BellaBeatCaseStudy.hourlySteps1`
  UNION ALL
  SELECT * FROM `newproject-496511.BellaBeatCaseStudy.hourlySteps2`
);

-- Merge weight_log from the two datasets from 3.12.16-4.11.16 and 4.12.16-5.12.16
CREATE OR REPLACE TABLE `newproject-496511.BellaBeatCaseStudy.weight_log` AS
SELECT DISTINCT * FROM (
  SELECT * FROM `newproject-496511.BellaBeatCaseStudy.weightLog1`
  UNION ALL
  SELECT * FROM `newproject-496511.BellaBeatCaseStudy.weightLog2`
);

-- Clean daily_activity by removing records with 0 steps and ensuring consistent date format
CREATE OR REPLACE TABLE `newproject-496511.BellaBeatCaseStudy.daily_activity_clean` AS
SELECT
  Id,
  ActivityDate,
  TotalSteps,
  TotalDistance,
  VeryActiveMinutes,
  FairlyActiveMinutes,
  LightlyActiveMinutes,
  SedentaryMinutes,
  Calories
FROM (
  SELECT * FROM `newproject-496511.BellaBeatCaseStudy.dailyActivity1`
  UNION ALL
  SELECT * FROM `newproject-496511.BellaBeatCaseStudy.dailyActivity2`
)
WHERE TotalSteps > 0;

-- Clean sleep_day by ensuring consistent date format and removing duplicates
CREATE OR REPLACE TABLE `newproject-496511.BellaBeatCaseStudy.sleep_day_clean` AS
SELECT DISTINCT
  Id,
  PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', SleepDay) AS SleepDay,
  TotalSleepRecords,
  TotalMinutesAsleep,
  TotalTimeInBed
FROM `newproject-496511.BellaBeatCaseStudy.sleep_day`;

-- Clean hourly_steps by ensuring consistent date format and removing duplicates
CREATE OR REPLACE TABLE `newproject-496511.BellaBeatCaseStudy.hourly_steps_clean` AS
SELECT
  Id,
  PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', ActivityHour) AS ActivityHour,
  StepTotal
FROM `newproject-496511.BellaBeatCaseStudy.hourly_steps`;

----------------------------------------------------------------------------------------------------------------------------------------------

--Shows the Average steps per day per ID (each person)
WITH daily_steps AS (
  SELECT
    Id,
    DATE(ActivityHour) AS Day,
    SUM(StepTotal) AS Total_steps_by_day
  FROM `newproject-496511.BellaBeatCaseStudy.hourly_steps_clean`
  GROUP BY Id, Day
)

SELECT
  Id,
  AVG(Total_steps_by_day) AS average_steps
FROM daily_steps
GROUP BY Id
ORDER BY average_steps DESC;

--Shows the TotalSteps and Calories to see if there is a corelation
select TotalSteps, Calories from `newproject-496511.BellaBeatCaseStudy.daily_activity_clean` order by Id DESC;

--Shows the actual corelation between the totalSteps and calories (0.56)
SELECT ROUND(CORR(TotalSteps, Calories), 2) AS correlation FROM `newproject-496511.BellaBeatCaseStudy.daily_activity_clean`;

--Shows how many hours people sleep by day
SELECT Id, DATE(SleepDay) AS Day, ROUND(TotalMinutesAsleep / 60, 2) AS HoursAslee FROM `newproject-496511.BellaBeatCaseStudy.sleep_day_clean`;

-- How many people sleep enough (more than 7 hours vs less)
WITH sleep_avg AS (
  SELECT
    Id,
    ROUND(AVG(TotalMinutesAsleep / 60), 2) AS AVGHoursAsleep
  FROM `newproject-496511.BellaBeatCaseStudy.sleep_day_clean`
  GROUP BY Id
)
SELECT Id, AVGHoursAsleep, case when AVGHoursAsleep > 7 then 'Sleeps enough' else 'Does not sleep enough' end as SleepCategory FROM sleep_avg;

--How much time people take to be asleep in AVG
SELECT Id, ROUND(AVG((TotalTimeInBed - TotalMinutesAsleep)), 2) AS avg_awake_before_sleep_min FROM `newproject-496511.BellaBeatCaseStudy.sleep_day_clean` GROUP BY Id ORDER BY avg_awake_before_sleep_min DESC;

--Average Steps per hour to see the most active hours
with StepsByHour as (
  Select 
  Extract(HOUR from ActivityHour) as Hour,
  Round(AVG(StepTotal), 2) as AvgStepHour
  from newproject-496511.BellaBeatCaseStudy.hourly_steps_clean
  group by Hour
)
select Hour, AvgStepHour from StepsByHour order by Hour ASC;

--Days of the week where people have the most steps
SELECT 
  FORMAT_DATE('%A', ActivityDate) AS DayOfWeek,
  ROUND(AVG(TotalSteps), 0) AS AvgSteps
FROM `newproject-496511.BellaBeatCaseStudy.daily_activity_clean`
GROUP BY DayOfWeek
ORDER BY AvgSteps DESC;

--How many peopple log their weight, sleep and activity
SELECT
  (SELECT COUNT(DISTINCT Id) FROM `newproject-496511.BellaBeatCaseStudy.daily_activity_clean`) AS users_activity,
  (SELECT COUNT(DISTINCT Id) FROM `newproject-496511.BellaBeatCaseStudy.sleep_day_clean`) AS users_sleep,
  (SELECT COUNT(DISTINCT Id) FROM `newproject-496511.BellaBeatCaseStudy.weight_log`) AS users_weight;
