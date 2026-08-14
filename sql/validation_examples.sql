-- SQL Validation Examples
-- Portfolio version of queries used during the capstone project.
-- All data and field names have been simplified for confidentiality.

--------------------------------------------------
-- 1. Count Open RFIs
--------------------------------------------------

SELECT
    project_id,
    COUNT(*) AS open_rfis
FROM rfis
WHERE status = 'Open'
GROUP BY project_id;


--------------------------------------------------
-- 2. Identify Overdue RFIs
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
-- 3. Average Days to Close
--------------------------------------------------

SELECT
    project_id,
    AVG(
        DATEDIFF(
            DAY,
            created_at,
            closed_at
        ) * 1.0
    ) AS avg_days_to_close
FROM rfis
WHERE closed_at IS NOT NULL
GROUP BY project_id;


--------------------------------------------------
-- 4. Most Recent Inspection Date
--------------------------------------------------

SELECT
    project_id,
    MAX(inspection_date) AS last_inspection_date
FROM inspections
GROUP BY project_id;
