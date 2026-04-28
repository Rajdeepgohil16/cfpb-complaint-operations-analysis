# Power BI Dashboard Notes

## Dashboard Purpose

The Power BI dashboard presents a portfolio-level view of CFPB complaint operations. It is designed for Complaint Operations Leadership to understand complaint concentration, timeliness risk, channel burden, and product-level prioritization.

## Dashboard Pages

The dashboard contains two pages:

1. Executive Overview
2. Operational Risk & Burden Prioritization

---

## Page 1: Executive Overview

### Purpose

This page answers:

> Where is complaint volume concentrated?

### Main KPIs

| KPI | Meaning |
|---|---|
| Total Complaints | Total scoped complaint records. |
| Narrative Presence Rate | Share of complaints with consumer narrative text. |
| Untimely Rate | Share of complaints marked as untimely. |
| Heavy-Channel Share | Share of complaints submitted through phone, postal mail, or referral. |

### Main Visuals

| Visual | Purpose |
|---|---|
| Complaint Volume by Product Domain | Shows product-level complaint concentration. |
| Monthly Complaint Volume Trend | Tracks complaint volume over time by received month. |
| Top Complaint Issues | Identifies recurring issues driving the largest workload. |
| Channel Slicer | Allows filtering by complaint submission channel. |

### Main Insight

Complaint demand is highly concentrated in Credit Reporting and a small number of recurring issue categories.

---

## Page 2: Operational Risk & Burden Prioritization

### Purpose

This page answers:

> Which product domains show higher risk or burden signals?

### Main KPIs

| KPI | Meaning |
|---|---|
| Avg Effort Proxy | Derived burden signal; not direct labor time. |
| Timely Rate | Overall published response timeliness. |
| Median Narrative Length | Median length of available complaint narratives. |
| Median Historical Age | Days since received; not true backlog duration. |

### Main Visuals

| Visual | Purpose |
|---|---|
| Heavy-Channel Share by Product Domain | Identifies domains with more phone, postal, or referral complaints. |
| Untimely Rate by Product Domain | Compares response-risk signals across product domains. |
| Historical Age Distribution | Shows historical age composition of complaint records. |
| Product Domain Risk & Burden Summary | Compares volume, untimely rate, heavy-channel share, effort signal, and median age. |

### Main Insight

Although Credit Reporting dominates total volume, smaller domains such as Mortgage and Checking / Savings show higher burden signals through heavy-channel share and effort proxy.

---

## Design Choices

- Blue is used for volume and count visuals.
- Red/orange is used for risk and burden indicators.
- Slate/gray is used for neutral supporting context.
- KPI cards use colored top bars to separate metric types.
- The summary table uses soft conditional formatting instead of strong heatmaps.
- The dashboard avoids donut charts because Credit Reporting dominates the product mix.
- The dashboard avoids standalone channel volume charts because the web channel dominates.

---

## Interpretation Notes

- Effort proxy is a derived signal, not direct labor time.
- Historical age is based on days since received, not true backlog duration.
- CFPB public complaint records do not represent full internal workflow telemetry.
- Segment-level results should be interpreted as operational signals, not complete workflow measurements.
