# CFPB Complaint Operations Analysis

## Python ETL · PostgreSQL · Power BI · Operational Analytics

This project analyzes public CFPB consumer complaint records to identify where complaint volume, untimely response risk, and operational burden signals are concentrated. The project was designed as an end-to-end analytics case study using Python for ETL and feature engineering, PostgreSQL for structured data modeling and validation, and Power BI for executive dashboard reporting.

The final dashboard is built for a **Complaint Operations Leadership** audience and focuses on turning large-scale complaint data into practical operational insights.

---

## Project Summary

Complaint operations teams often need to understand not only where complaint volume is highest, but also where risk and workload signals are unevenly distributed. This project uses cleaned CFPB complaint records to answer:

- Which product domains generate the most complaint volume?
- Which complaint issues create the largest operational workload?
- Which product areas show higher untimely response signals?
- Which segments show higher burden signals through heavy-channel share, narrative length, and effort proxy?
- How can complaint operations leaders prioritize attention across product domains?

---

## Business Problem

Complaint handling demand is concentrated in a small number of product and issue areas. At the same time, untimely risk and operational burden are not evenly distributed across the portfolio.

A high-level complaint count alone does not fully explain operational pressure. A smaller product domain may have lower volume but higher burden signals, such as more phone/postal/referral complaints, longer narratives, or higher effort-proxy scores.

---

## Analytical Objective

The objective of this project is to identify where complaint volume, untimely response risk, and operational burden signals are concentrated, then summarize those findings through a Power BI dashboard that supports operational prioritization.

---

## Tools and Technologies

| Area | Tools Used |
|---|---|
| Data Processing | Python, pandas, NumPy |
| Data Storage / Modeling | PostgreSQL |
| Dashboarding | Power BI |
| File Formats | CSV, Parquet |
| Documentation | Markdown, GitHub |
| Visualization / EDA | matplotlib, Power BI |

---

## Dataset

The project uses public complaint records from the Consumer Financial Protection Bureau (CFPB).

The final scoped dataset focuses on four product domains:

- Credit Reporting
- Debt Collection
- Checking / Savings
- Mortgage

The full cleaned dataset contains approximately **8.67 million scoped complaint records**.

Full raw and cleaned data files are not included in this repository because they are too large for GitHub. See [`data/README.md`](data/README.md) for data access and reproducibility notes.

---

## Repository Structure

```text
cfpb-complaint-operations-analysis/
│
├── README.md
├── requirements.txt
├── .gitignore
├── LICENSE
│
├── src/
│   └── etl_pipeline.py
│
├── notebooks/
│   └── cfpb_post_etl_analysis.ipynb
│
├── SQL/
│   ├── 01_schema.sql
│   ├── 02_load.sql
│   ├── 03_validation.sql
│   ├── 04_views.sql
│   └── 05_analysis_queries.sql
│
├── powerbi/
│   └── screenshots/
│       ├── executive_overview.png
│       └── operational_risk_burden.png
│
├── docs/
│   ├── data_dictionary.md
│   ├── methodology.md
│   └── dashboard_notes.md
│
└── data/
    └── README.md
```

---

## ETL Pipeline Overview

The Python ETL pipeline performs the following steps:

1. Loads raw CFPB complaint data.
2. Validates required source columns.
3. Parses date fields.
4. Standardizes complaint IDs.
5. Deduplicates records using complaint ID.
6. Applies a rolling 3-year analysis window.
7. Standardizes product, issue, company, and channel fields.
8. Maps products into focused product domains.
9. Engineers operational analytics fields.
10. Exports cleaned outputs for PostgreSQL and Power BI.

Main generated outputs include:

```text
stg_complaints_scoped.parquet
stg_complaints_scoped_postgres.csv
bridge_complaint_tag_scoped.parquet
bridge_complaint_tag_scoped_postgres.csv
sample_scoped_100k.csv
dq_run_kpis.csv
pipeline_run_metadata.json
```

These generated files are not stored in the repository due to size constraints.

---

## Key Engineered Fields

| Field | Purpose |
|---|---|
| `timely_flag` | Indicates whether the complaint response was timely. |
| `untimely_flag` | Identifies untimely response risk. |
| `has_narrative_flag` | Indicates whether a consumer narrative is available. |
| `narrative_length_chars` | Measures complaint narrative length. |
| `heavy_channel_flag` | Flags phone, postal mail, and referral complaints. |
| `intake_to_routing_days` | Measures days between complaint receipt and sent-to-company date. |
| `days_since_received` | Measures historical age relative to the ETL as-of date. |
| `effort_score` | Derived proxy for operational burden. |

Important note: `effort_score` is a proxy signal and should not be interpreted as direct labor time, cost, or true processing effort.

---

## Power BI Dashboard

The Power BI dashboard contains two pages:

1. **Executive Overview**
2. **Operational Risk & Burden Prioritization**

The `.pbix` file is not included because it exceeds normal GitHub browser upload limits and contains a large imported dataset. Dashboard screenshots are included below.

---

### Page 1: Executive Overview

This page summarizes complaint volume, narrative coverage, untimely response rate, heavy-channel share, product-domain concentration, complaint trend, and top recurring issues.

![Executive Overview](powerbi/screenshots/executive_overview.png)

Key dashboard elements:

- Total complaints KPI
- Narrative presence rate KPI
- Untimely response rate KPI
- Heavy-channel share KPI
- Complaint volume by product domain
- Monthly complaint volume trend
- Top complaint issues
- Channel filter

---

### Page 2: Operational Risk & Burden Prioritization

This page focuses on product-level risk and burden signals, including effort proxy, timeliness, narrative length, historical age, heavy-channel share, untimely rate, age distribution, and a product-domain risk summary table.

![Operational Risk & Burden](powerbi/screenshots/operational_risk_burden.png)

Key dashboard elements:

- Average effort proxy KPI
- Timely rate KPI
- Median narrative length KPI
- Median historical age KPI
- Heavy-channel share by product domain
- Untimely rate by product domain
- Historical age distribution
- Product domain risk and burden summary

---

## Key Metrics

| Metric | Value |
|---|---:|
| Total Complaints | 8.67M |
| Narrative Presence Rate | 23.16% |
| Untimely Rate | 0.25% |
| Heavy-Channel Share | 0.78% |
| Timely Rate | 99.75% |
| Average Effort Proxy | 0.07 |
| Median Narrative Length | 642 characters |
| Median Historical Age | 407 days |

---

## Key Findings

### 1. Complaint volume is highly concentrated

Credit Reporting accounts for the majority of complaint volume in the scoped dataset. This indicates that operational improvement in a small number of high-volume product and issue areas could have broad portfolio impact.

### 2. A small set of recurring issues drives most workload

The largest complaint issues are concentrated around credit reporting accuracy, improper use of reports, and company investigation problems. These issue groups create the largest repeat workload patterns.

### 3. Overall timeliness is strong

The overall timely response rate is very high, while the untimely rate is low. However, segment-level analysis is still useful because high-level performance can hide smaller areas of elevated risk.

### 4. Smaller product domains show higher burden signals

Although Mortgage and Checking / Savings have much lower complaint volume than Credit Reporting, they show stronger burden signals through higher heavy-channel share and effort-proxy patterns.

### 5. Channel mix matters for operational interpretation

The web channel dominates complaint volume, but phone, postal mail, and referral channels are treated as heavier operational channels because they may require more manual or specialized handling.

---

## Recommendations

Based on the analysis, Complaint Operations Leadership should consider:

1. Prioritizing high-volume Credit Reporting issues for process standardization and routing efficiency.
2. Monitoring Debt Collection as a higher untimely-risk area relative to other domains.
3. Treating phone, postal mail, and referral complaints as distinct workflows rather than grouping them with standard web complaints.
4. Reviewing Mortgage and Checking / Savings complaints for complexity signals such as longer narratives and higher heavy-channel share.
5. Using a combined prioritization view that balances volume, untimely risk, heavy-channel share, and effort proxy rather than relying on complaint count alone.

---

## Limitations

This analysis should be interpreted as portfolio-level operational analytics, not full internal workflow measurement.

Important limitations:

- CFPB public complaint records do not include internal queue movement, staffing assignments, handoffs, or true resolution lifecycle data.
- `days_since_received` measures historical age relative to the ETL as-of date. It should not be interpreted as true backlog duration.
- `effort_score` is a derived proxy and does not represent direct labor time, cost, or exact processing effort.
- Some fields are optional or missing, including narrative text and public response fields.
- The full raw and cleaned datasets are excluded from GitHub due to file size.

---

## How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/cfpb-complaint-operations-analysis.git
cd cfpb-complaint-operations-analysis
```

### 2. Install Python dependencies

```bash
pip install -r requirements.txt
```

### 3. Add the raw CFPB data

Download the CFPB complaint export and place it here:

```text
data/raw/complaints.csv
```

### 4. Run the ETL pipeline

```bash
python src/etl_pipeline.py
```

### 5. Load data into PostgreSQL

Use the SQL scripts in this order:

```text
SQL/01_schema.sql
SQL/02_load.sql
SQL/03_validation.sql
SQL/04_views.sql
SQL/05_analysis_queries.sql
```

### 6. Review the Power BI dashboard

Dashboard screenshots are available in:

```text
powerbi/screenshots/
```

The Power BI `.pbix` file is not included because of file size.

---

## Portfolio Value

This project demonstrates:

- End-to-end analytics workflow design
- Large-scale data cleaning and transformation
- Reproducible ETL pipeline development
- PostgreSQL schema, loading, validation, and analysis layer
- Power BI dashboard design and business storytelling
- Operational KPI development
- Risk and burden signal interpretation
- Clear communication of assumptions and limitations

---

## Project Status

Completed:

- Python ETL pipeline
- Post-ETL analysis
- PostgreSQL SQL scripts
- Power BI dashboard screenshots
- Data dictionary
- Methodology notes
- Dashboard documentation



---

## Author

Created as a data analytics portfolio project focused on complaint operations, business intelligence, and operational risk analysis.
