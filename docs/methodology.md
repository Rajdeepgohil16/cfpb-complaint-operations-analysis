# Methodology

## 1. Project Objective

This project analyzes CFPB consumer complaint records to identify where complaint volume, untimely response risk, and operational burden signals are concentrated.

The intended stakeholder is Complaint Operations Leadership. The goal is to support operational prioritization across product domains, issues, and submission channels.

## 2. Data Source

The project uses CFPB published consumer complaint records. These records are useful for portfolio-level complaint analysis, but they do not represent full internal workflow telemetry.

Important limitation: the data does not include internal queue movement, staffing assignments, handoffs, or full resolution lifecycle details.

## 3. ETL Process

The Python ETL pipeline performs the following steps:

1. Loads raw CFPB complaint data.
2. Validates required source columns.
3. Parses complaint dates.
4. Standardizes complaint IDs.
5. Deduplicates records using complaint ID.
6. Applies a rolling 3-year analysis window.
7. Standardizes text fields such as product, issue, company, and channel.
8. Maps products into focused product domains.
9. Engineers operational analytics fields.
10. Exports cleaned parquet and PostgreSQL-ready CSV outputs.

## 4. Scope

The final dashboard focuses on four product domains:

- Credit Reporting
- Debt Collection
- Checking / Savings
- Mortgage

These domains were selected because they represent major complaint areas and support focused operational analysis.

## 5. Feature Engineering

Key engineered fields include:

| Field | Purpose |
|---|---|
| timely_flag | Measures whether the response was timely. |
| untimely_flag | Measures response-risk signal. |
| has_narrative_flag | Identifies complaints with consumer narrative text. |
| narrative_length_chars | Provides a text-complexity signal. |
| heavy_channel_flag | Identifies phone, postal mail, and referral complaints. |
| intake_to_routing_days | Measures process lag between receipt and sent-to-company date. |
| days_since_received | Measures historical age relative to the ETL as-of date. |
| effort_score | Derived proxy for operational burden. |

## 6. Power BI Dashboard Design

The Power BI dashboard contains two pages:

### Page 1: Executive Overview

This page summarizes complaint volume and concentration.

Main visuals:

- Total complaint KPI
- Narrative presence KPI
- Untimely rate KPI
- Heavy-channel share KPI
- Complaint volume by product domain
- Monthly complaint volume trend
- Top complaint issues
- Channel slicer

### Page 2: Operational Risk & Burden Prioritization

This page compares risk and burden signals by product domain.

Main visuals:

- Average effort proxy KPI
- Timely rate KPI
- Median narrative length KPI
- Median historical age KPI
- Heavy-channel share by product domain
- Untimely rate by product domain
- Historical age distribution
- Product domain risk and burden summary table

## 7. Interpretation Approach

The analysis separates portfolio-level volume from segment-level risk.

A product domain can be high priority because it has:

- high complaint volume,
- higher untimely response rate,
- higher heavy-channel share,
- higher effort proxy,
- or older historical complaint age.

## 8. Limitations

- CFPB public complaint records are not full internal workflow data.
- Historical age is not the same as internal backlog duration.
- Effort score is a proxy, not a direct measure of labor time or cost.
- Some fields are optional or missing, including consumer narratives and public responses.
- Results should be interpreted as operational signals, not complete workflow measurement.
