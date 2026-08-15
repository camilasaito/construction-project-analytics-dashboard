-- SQL examples created for this portfolio using synthetic data.
-- These queries are based on the types of validation and database
-- exploration I performed during the capstone.
--
-- They are not copied from the company database or production queries.
-- The data, IDs, and values are synthetic. Some table and field names
-- use common construction terminology also used during the project,
-- but no company-specific database structure or confidential information
-- is included.

--------------------------------------------------
-- 1. Exploring a database schema
--------------------------------------------------

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY
    TABLE_SCHEMA,
    TABLE_NAME,
    ORDINAL_POSITION;


--------------------------------------------------
-- 2. Finding project-related tables
--------------------------------------------------

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%project%';


--------------------------------------------------
-- 3. Checking available project IDs
--------------------------------------------------

SELECT DISTINCT
    project_id
FROM projects
ORDER BY project_id;


--------------------------------------------------
-- 4. Checking how many RFIs are still open
--------------------------------------------------

SELECT
    project_id,
    COUNT(*) AS open_rfis
FROM rfis
WHERE status = 'Open'
GROUP BY project_id;


--------------------------------------------------
-- 5. Checking overdue RFIs
--------------------------------------------------

SELECT
    project_id,
    rfi_id,
    status,
    due_date
FROM rfis
WHERE status = 'Open'
  AND due_date < GETDATE();


--------------------------------------------------
-- 6. Checking RFI status distribution
--------------------------------------------------

SELECT
    project_id,
    status,
    COUNT(*) AS status_count
FROM rfis
GROUP BY
    project_id,
    status
ORDER BY
    project_id,
    status;


--------------------------------------------------
-- 7. Checking average days to close for RFIs
--------------------------------------------------

SELECT
    project_id,
    AVG(
        DATEDIFF(
            DAY,
            created_date,
            closed_date
        ) * 1.0
    ) AS avg_days_to_close
FROM rfis
WHERE closed_date IS NOT NULL
GROUP BY project_id;


--------------------------------------------------
-- 8. Checking individual RFI closure time
--------------------------------------------------

SELECT
    project_id,
    rfi_id,
    created_date,
    closed_date,
    DATEDIFF(
        DAY,
        created_date,
        closed_date
    ) AS days_to_close
FROM rfis
WHERE closed_date IS NOT NULL;


--------------------------------------------------
-- 9. Checking for missing RFI dates
--------------------------------------------------

SELECT
    project_id,
    rfi_id,
    created_date,
    due_date,
    closed_date
FROM rfis
WHERE created_date IS NULL
   OR due_date IS NULL;


--------------------------------------------------
-- 10. Checking the most recent inspection
--------------------------------------------------

SELECT
    project_id,
    MAX(inspection_date) AS last_inspection_date
FROM inspections
GROUP BY project_id;


--------------------------------------------------
-- 11. Checking inspection results by project
--------------------------------------------------

SELECT
    project_id,
    result,
    COUNT(*) AS inspection_count
FROM inspections
GROUP BY
    project_id,
    result
ORDER BY
    project_id,
    result;


--------------------------------------------------
-- 12. Checking open deficiencies
--------------------------------------------------

SELECT
    project_id,
    COUNT(*) AS open_deficiencies
FROM deficiencies
WHERE status = 'Open'
GROUP BY project_id;


--------------------------------------------------
-- 13. Checking overdue deficiencies
--------------------------------------------------

SELECT
    project_id,
    deficiency_id,
    due_date
FROM deficiencies
WHERE status = 'Open'
  AND due_date < GETDATE();


--------------------------------------------------
-- 14. Checking average days to close for deficiencies
--------------------------------------------------

SELECT
    project_id,
    AVG(
        DATEDIFF(
            DAY,
            created_date,
            closed_date
        ) * 1.0
    ) AS avg_days_to_close
FROM deficiencies
WHERE closed_date IS NOT NULL
GROUP BY project_id;


--------------------------------------------------
-- 15. Checking Lost Time Injuries
--------------------------------------------------

SELECT
    project_id,
    COUNT(*) AS lost_time_injuries
FROM safety
WHERE lost_time_flag = 1
GROUP BY project_id;


--------------------------------------------------
-- 16. Checking the most recent Lost Time Injury
--------------------------------------------------

SELECT
    project_id,
    MAX(incident_date) AS last_lti_date
FROM safety
WHERE lost_time_flag = 1
GROUP BY project_id;


--------------------------------------------------
-- 17. Checking site activity
--------------------------------------------------

SELECT
    project_id,
    activity_date,
    people_on_site,
    trades_on_site
FROM site_activity
ORDER BY
    project_id,
    activity_date DESC;
