USE multiple_disease_prediction;

-- Add an id column for easier reference
ALTER TABLE diabetes_data
ADD COLUMN id SERIAL PRIMARY KEY;

-- Show all variables in the database
SELECT * 
FROM diabetes_data;


-- Average values per diabetic outcome
-- Shows how health indicators differ 'diabetics' and 'non-diabetics'
SELECT Outcome,
       AVG(Pregnancies) AS avg_pregnancies,
       AVG(Glucose) AS avg_glucose,
       AVG(BloodPressure) AS avg_bp,
       AVG(Insulin) AS avg_insulin,
       AVG(BMI) AS avg_bmi,
       AVG(Age) AS avg_age
FROM diabetes_data
GROUP BY Outcome;


-- Top 5 highest glucose readings among diabetic 
-- (Helps identify severe cases in diabetic patients.)
SELECT *
FROM diabetes_data
WHERE Outcome = 1
ORDER BY Glucose DESC
LIMIT 5;


-- Count of diabetics and non-diabetic
-- useful for knowing if your model is trained on balanced data
SELECT Outcome, COUNT(*) AS count
FROM diabetes_data
GROUP BY Outcome;


-- BMI (body mass index) breakdown among diabetics
-- Show relevance of obesity among diabetic patients
SELECT
  CASE 
    WHEN BMI < 18.5 THEN 'Underweight'
    WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Normal'
    WHEN BMI BETWEEN 25 AND 29.9 THEN 'Overweight'
    ELSE 'Obese'
  END AS BMI_Category,
  COUNT(*) AS count
FROM diabetes_data
WHERE Outcome = 1
GROUP BY BMI_Category;


-- Correlation between age and glucose levels
-- visual insight into how glucose levels rise with age
SELECT Age, AVG(Glucose) AS avg_glucose
FROM diabetes_data
GROUP BY Age
ORDER BY Age;


-- High Risk Individual
-- Pinpoint individuals with high indicators of diabetes risk
SELECT *
FROM diabetes_data
WHERE Age > 45 AND Glucose > 150 AND BMI > 30;


-- Breaking down diabetes outcome by age group
-- Shows how diabetes likelihood changes across life stages.
SELECT 
  CASE 
    WHEN Age < 30 THEN 'Under 30'
    WHEN Age BETWEEN 30 AND 45 THEN '30-45'
    WHEN Age BETWEEN 46 AND 60 THEN '46-60'
    ELSE 'Over 60'
  END AS Age_Group,
  COUNT(*) AS Total_People,
  SUM(CASE WHEN Outcome = 1 THEN 1 ELSE 0 END) AS Diabetic_Count,
  ROUND(AVG(Outcome) * 100, 2) AS Diabetes_Rate_Percent
FROM diabetes_data
GROUP BY Age_Group
ORDER BY Age_Group;


-- Most common combination of characteristics among diabetic patients
-- Shows common health markers among diabetics
SELECT Pregnancies, Glucose, BloodPressure, BMI, COUNT(*) AS Count
FROM diabetes_data
WHERE Outcome = 1
GROUP BY Pregnancies, Glucose, BloodPressure, BMI
ORDER BY Count DESC
LIMIT 5;



-- Checking if higher BMI is associated with higher diabetes rates
-- Shows how risk increases with BMI
SELECT 
  ROUND(BMI, 0) AS BMI_Rounded,
  COUNT(*) AS Total,
  SUM(CASE WHEN Outcome = 1 THEN 1 ELSE 0 END) AS Diabetics,
  ROUND(SUM(Outcome) * 1.0 / COUNT(*), 2) AS Diabetes_Rate
FROM diabetes_data
GROUP BY BMI_Rounded
HAVING COUNT(*) > 5
ORDER BY Diabetes_Rate DESC
LIMIT 10;



-- Identify high risk non-diabetic patients
-- possibly undiagnosed cases
SELECT *
FROM diabetes_data
WHERE Glucose > 150 AND Outcome = 0
ORDER BY Glucose DESC;


-- Shows how pregnancies might affect glucose levels
SELECT Pregnancies, ROUND(AVG(Glucose), 2) AS Avg_Glucose
FROM diabetes_data
GROUP BY Pregnancies
ORDER BY Pregnancies;
