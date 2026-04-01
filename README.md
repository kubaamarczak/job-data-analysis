# 📊 Data Analyst Job Market Analysis (Germany)

## 📌 Project Overview
This project analyzes the job market for **Data Analyst roles in Germany**, focusing on:

- 💰 Salary distribution of top-paying jobs  
- 🧠 Skills associated with high salaries  
- ⚖️ Optimal skills balancing demand and salary  

The goal is to identify **which skills maximize earning potential** and provide actionable insights for aspiring data analysts.

---

## 📂 Dataset
The analysis is based on four relational datasets:

- `job_postings_fact.csv` → Top-paying Data Analyst jobs in Berlin  
- `company_dim.csv` → Top 25 skills associated with highest salaries  
- `skills_job_dim.csv` → Skills balancing demand and salary
- `skills_dim.csv` → Skills balancing demand and salary

---

## 🛠️ Tools & Technologies
- SQL (data extraction & transformation)
- PostgreSQL / SQL environment
- Git & GitHub

---

## 📊 Analysis

### 1. 💰 Salary Analysis (Top Roles)
Key findings from the highest-paying Data Analyst roles:

- Salary range: **~57k – 166k €**
- Most salaries cluster around **100k – 110k €**
- A few extreme outliers exceed **150k €**

👉 **Insight:**
> High-paying roles are relatively concentrated, but extreme salaries indicate senior or specialized positions.

---

### 2. 🧠 Skills vs Salary (Top 25 Skills)

#### 🔝 Highest-paying skills:
- Kafka, Terraform, BigQuery, Redshift, NoSQL (~166k €)

👉 **Insight:**
> The highest-paying “Data Analyst” roles heavily overlap with **Data Engineering skills**.

---

#### ☁️ Cloud & Big Data:
- GCP, Databricks, Spark → significantly higher salaries

👉 **Insight:**
> Cloud and big data technologies are strong salary drivers.

---

#### 🐍 Python & Classic Tools:
- Python, Pandas, NumPy (~105k €)

👉 **Insight:**
> Python is essential but **not a differentiating factor** for top salaries.

---

#### 📊 BI Tools:
- Power BI (~97k €)

👉 **Insight:**
> Pure BI skills are associated with lower salaries.

---

### 3. ⚖️ Optimal Skills (Demand + Salary)

This dataset highlights skills that balance:
- High demand
- Strong salaries

#### 💡 Key Skills:
- SQL  
- Python  
- Tableau / BI tools  
- Cloud technologies  

👉 **Insight:**
> The most valuable skills are those that combine **market demand with solid salaries**, not just extreme pay.

---

## 🔥 Key Takeaways

### 1. Engineering Skills Drive Salary
> The highest-paying roles require data engineering and cloud expertise rather than pure analytics.

---

### 2. Cloud & Big Data Are Game-Changers
> Skills like BigQuery, Kafka, and Spark are strongly associated with higher salaries.

---

### 3. Python Is a Baseline Skill
> Python is widely required but does not differentiate candidates at the top salary level.

---

### 4. BI Alone Is Not Enough
> Roles focused only on dashboards tend to have lower salaries.

---

## 🎯 Career Implications

To reach top-paying Data Analyst roles:

- Learn **SQL + Python** (foundation)
- Add **Cloud (GCP/AWS)** knowledge
- Build **Data Engineering skills** (pipelines, big data tools)

---

## 🚀 Future Improvements

- Add data visualizations (salary distribution, skill frequency)
- Expand analysis to other cities
- Combine SQL with Python for deeper insights

---

## 📬 Author
Created by Jakub Marczak