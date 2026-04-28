# Data Folder

This repository does not include the full raw or cleaned CFPB complaint datasets because the files are too large for GitHub.

## Data Source

This project uses public consumer complaint records from the Consumer Financial Protection Bureau (CFPB).

The raw CFPB complaint export should be downloaded separately and placed in the following path before running the ETL pipeline:

```text
data/raw/complaints.csv
```

## Why the Data Is Not Included

The full raw and cleaned datasets are excluded from this repository because they are large files and are not suitable for direct GitHub upload.

Excluded files include:

```text
complaints.csv
stg_complaints_scoped.parquet
stg_complaints_scoped_postgres.csv
bridge_complaint_tag_scoped.parquet
bridge_complaint_tag_scoped_postgres.csv
sample_scoped_100k.csv
dq_run_kpis.csv
pipeline_run_metadata.json
```

## Generated Outputs

After running the Python ETL pipeline, cleaned outputs are generated in:

```text
data/clean/
```

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

## Power BI Data Note

The Power BI `.pbix` file is not included in this repository because it contains a large imported dataset and exceeds normal GitHub browser upload limits.

Instead, dashboard screenshots are provided in:

```text
powerbi/screenshots/
```

## Reproducibility Notes

To reproduce the project:

1. Download the CFPB complaint data.
2. Save the raw CSV as `data/raw/complaints.csv`.
3. Run the ETL pipeline in `src/etl_pipeline.py`.
4. The cleaned files will be created in `data/clean/`.
5. Use the cleaned output for PostgreSQL loading and Power BI dashboarding.

## Important Interpretation Notes

- The data comes from CFPB published complaint records.
- CFPB public complaint records are useful for portfolio-level complaint analysis.
- The data does not represent full internal workflow telemetry.
- Historical age fields should not be interpreted as true internal backlog duration.
- Effort-related fields are derived proxy signals, not direct labor time or cost.
