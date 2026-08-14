-- Some SQL examples I used during the capstone
-- I used these queries mainly to check if the numbers in Tableau were correct.
-- The names and data were simplified for this portfolio.

--------------------------------------------------
-- 1. Checking how many RFIs were still open
--------------------------------------------------

SELECT
    project_id,
    COUNT(*) AS open_rfis
FROM rfis
WHERE status = 'Open'
GROUP BY project_id;


--------------------------------------------------
-- 2. Checking overdue RFIs
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
-- 3. Checking average days to close
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
-- 4. Checking the most recent inspection
--------------------------------------------------

SELECT
    project_id,
    MAX(inspection_date) AS last_inspection_date
FROM inspections
GROUP BY project_id;
