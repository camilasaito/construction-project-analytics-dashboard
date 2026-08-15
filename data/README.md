# Synthetic Data

The original client data is not included in this repository.

For the portfolio version, I created synthetic construction project data in Python. The generated CSV files use a shared `project_id` so they can be related in Tableau.

The data was created only to recreate the dashboard structure, calculations, filters, and KPI logic without using confidential company information.

## Files

- `projects.csv` – synthetic project information
- `rfis.csv` – synthetic RFI records
- `submittals.csv` – synthetic submittal records
- `observations.csv` – synthetic observation records
- `inspections.csv` – synthetic inspection records
- `deficiencies.csv` – synthetic deficiency records
- `safety.csv` – synthetic safety records
- `site_activity.csv` – synthetic site activity

The Python script used to generate these files is available in `generate_synthetic_data.py`.

## Privacy Note

The files, project names, IDs, and values in the synthetic data were created only for this portfolio.

File and field names use common construction terminology and do not represent the company’s internal database structure or naming conventions.
