# 🩺 Diabetes Dataset SQL Analysis

This project uses **SQL queries** to analyze a diabetes dataset and extract insights related to patient health and diabetes risk factors. The goal is to explore patterns in the data that can improve predictive modeling and inform decision-making in healthcare.

---

## 🗃️ Database Used
- **Database Name:** `multiple_disease_prediction`
- **Table Name:** `diabetes_data`

---

## 📊 Dataset Overview

The dataset contains 768 entries with the following features:

| Column Name              | Description                                                  |
|--------------------------|--------------------------------------------------------------|
| `Pregnancies`            | Number of times pregnant                                     |
| `Glucose`                | Plasma glucose concentration (mg/dL)                         |
| `BloodPressure`          | Diastolic blood pressure (mm Hg)                             |
| `SkinThickness`          | Triceps skinfold thickness (mm)                              |
| `Insulin`                | 2-Hour serum insulin (mu U/ml)                               |
| `BMI`                    | Body Mass Index (weight in kg/(height in m)^2)              |
| `DiabetesPedigreeFunction` | Diabetes likelihood based on family history               |
| `Age`                    | Age in years                                                 |
| `Outcome`                | 0 = Non-diabetic, 1 = Diabetic                               |
| `id`                     | Unique identifier (auto-incremented primary key)             |

---

## 🧠 Key Insights Extracted

### 🔹 Basic Stats & Distribution
- **Average values per diabetic outcome**
- **Top 5 glucose readings among diabetics**
- **Diabetes vs Non-diabetes count**

### 🔹 Health Factor Insights
- **BMI category distribution among diabetics**
- **Average glucose level by age**
- **High-risk individuals: age > 45, glucose > 150, BMI > 30**
- **Most common diabetic patient profiles**

### 🔹 Demographic Segmentation
- **Diabetes prevalence by age group**
- **Pregnancies vs glucose level correlation**

### 🔹 Data Quality Check
- **Detection of high glucose in non-diabetics** (potential undiagnosed cases)
- **BMI correlation with diabetes rate**

---

## 📂 Example Queries

### Get average health indicators by diabetic status:
```sql
SELECT Outcome, AVG(Glucose), AVG(BMI), AVG(Age)
FROM diabetes_data
GROUP BY Outcome;

