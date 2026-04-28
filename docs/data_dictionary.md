# Data Dictionary

This project uses cleaned post-ETL CFPB complaint records for operational analytics and Power BI reporting.

## Main Table: `stg_complaints_scoped`

| Column | Description |
|---|---|
| complaint_id | Unique complaint record identifier. Used for distinct complaint counts. |
| date_received | Date the complaint was received. Used for monthly trend analysis. |
| date_sent_to_company | Date the complaint was sent to the company. |
| as_of_date | ETL reference date used to calculate historical age. |
| company_raw | Original company name from the source file. |
| company_std | Standardized company name. |
| product_raw | Original product field from the source file. |
| product_std | Standardized product text. |
| product_domain | High-level product grouping used for dashboard segmentation. |
| issue_raw | Original issue field from the source file. |
| issue_std | Standardized complaint issue label. |
| state | Consumer state. Used for geographic filtering. |
| zip3 | First three digits of ZIP code. |
| zip5 | Five-digit ZIP code when available. |
| channel_std | Standardized complaint submission channel. |
| timely_flag | 1 if the complaint response was timely, 0 otherwise. |
| untimely_flag | 1 if the complaint response was untimely, 0 otherwise. |
| has_narrative_flag | 1 if consumer narrative text is available, 0 otherwise. |
| narrative_length_chars | Length of the consumer narrative in characters. |
| intake_to_routing_days | Days between complaint received date and sent-to-company date. |
| days_since_received | Days from complaint received date to the ETL as-of date. |
| days_since_received_bucket | Original bucketed age field; not used in final dashboard because it was too concentrated. |
| heavy_channel_flag | 1 for phone, postal mail, or referral; 0 otherwise. |
| long_narrative_flag | 1 if narrative length is at or above the scoped 75th percentile. |
| effort_score | Derived effort proxy based on untimely response, dispute flag, long narrative, and heavy channel. |
| effort_unknown_flag | Indicator for missing components used in effort-score logic. Not used in final dashboard. |

## Important Notes

- `effort_score` is a derived proxy, not direct labor time or cost.
- `days_since_received` is historical age, not true backlog duration.
- CFPB public complaint records do not represent full internal workflow telemetry.
- The final Power BI dashboard focuses on four product domains: Credit Reporting, Debt Collection, Checking / Savings, and Mortgage.
