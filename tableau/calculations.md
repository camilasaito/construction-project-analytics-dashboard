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
```

## Days to Close

Used to calculate how many days it took to close an item.

```tableau
DATEDIFF('day', [Created Date], [Closed Date])
```

## Days Since Last Inspection

Used to calculate the number of days since the most recent inspection.

```tableau
DATEDIFF('day', [Inspection Date], TODAY())
```

## Days Since Last Lost Time Injury

Used to calculate the number of days since the most recent lost time injury.

```tableau
DATEDIFF(
    'day',
    MAX(
        IF [LTI Flag] = 1
        THEN [Date of Incident]
        END
    ),
    TODAY()
)
```
