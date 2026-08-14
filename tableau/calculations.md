# Tableau Calculations

This file documents selected Tableau calculated fields used in the capstone dashboard.

## Overdue Items

Used to identify records that are still open and past their due date.

```tableau
IF [Status] = "Open"
AND [Due Date] < TODAY()
THEN "Overdue"
ELSE "Not Overdue"
END
