-- 02_load.sql
-- Replace the two FILEPATH values below on your machine before running.
.

TRUNCATE TABLE stg.complaint_tag_bridge;
TRUNCATE TABLE stg.complaints_scoped;

-- complaints file
\copy stg.complaints_scoped
FROM '<PATH_TO_CLEAN_FOLDER>/stg_complaints_scoped_postgres.csv'
WITH (
    FORMAT csv,
    HEADER true,
    NULL '',
    ENCODING 'UTF8'
);

-- tag bridge file
\copy stg.complaint_tag_bridge
FROM '<PATH_TO_CLEAN_FOLDER>/bridge_complaint_tag_scoped_postgres.csv'
WITH (
    FORMAT csv,
    HEADER true,
    NULL '',
    ENCODING 'UTF8'
);