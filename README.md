# End-to-End Hiring Analytics Platform

An end-to-end recruitment analytics project built to help HR and talent acquisition teams understand hiring-funnel performance, sourcing-channel effectiveness, recruitment costs, and time-to-hire.

The project demonstrates a complete analytics workflow: **Python data preparation → PostgreSQL → dbt transformations → Power BI dashboards**. It uses synthetic recruitment data for portfolio and learning purposes.

## Table of Contents

- [Business Problem](#business-problem)
- [Objectives](#objectives)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Key Features](#key-features)
- [KPIs and Business Metrics](#kpis-and-business-metrics)
- [Multi-Touch Attribution](#multi-touch-attribution)
- [Power BI Dashboards](#power-bi-dashboards)
- [Data and Assumptions](#data-and-assumptions)
- [Getting Started](#getting-started)
- [Running dbt](#running-dbt)
- [Project Structure](#project-structure)
- [Limitations and Future Enhancements](#limitations-and-future-enhancements)

## Business Problem

Recruitment teams need to understand more than the number of candidates hired. They need to know where candidates leave the hiring process, which sourcing channels contribute to hires, how much those channels cost, and how long recruitment takes.

This platform brings those questions together in a repeatable data pipeline and a set of interactive Power BI reports.

## Objectives

- Analyze candidate progression through the recruitment funnel.
- Measure stage conversion and candidate drop-off.
- Compare sourcing channels using hiring volume, conversion, and cost metrics.
- Compare first-touch, last-touch, and linear attribution approaches.
- Track hiring trends and time-to-hire.
- Build reusable, testable SQL transformations for downstream reporting.

## Technology Stack

| Technology | Purpose |
|---|---|
| Python and pandas | Generate and prepare data, clean fields, and export CSV files |
| CSV | Portable input files for the data pipeline |
| PostgreSQL | Store raw and analytical data and support SQL analysis |
| dbt Core | Organize SQL transformations, model dependencies, seeds, and data tests |
| Power BI | Interactive dashboards, KPI cards, slicers, and visual analysis |
| DAX | Calculate dashboard measures and business KPIs |

## Architecture

```text
Synthetic recruitment data
          |
          v
   CSV input files
          |
          v
Python / pandas
Data cleaning and validation
          |
          v
      PostgreSQL
Raw source tables and seed data
          |
          v
          dbt
Staging -> intermediate / fact models
          |
          v
Business marts and attribution models
          |
          v
       Power BI
Recruitment funnel, sourcing ROI,
attribution, and hiring-time analysis
```

## Key Features

### 1. Recruitment Funnel Analytics

Analyze candidate progression through stages such as:

**Applied → Screened → Interviewed → Offered → Hired**

The funnel and stage-level metrics help reveal where candidate volume decreases. Stage counts should use distinct candidate identifiers where candidates can have multiple event records.

### 2. Sourcing Channel Performance

Compare channels such as LinkedIn, Naukri, referrals, agencies, and career sites using available source fields and cost data.

Questions the analysis can answer include:

- Which channel contributes the most hires?
- Which channel has the highest candidate-to-hire conversion?
- Which channel has the lowest cost per hire?
- Does the highest-volume channel also perform efficiently?

### 3. Multi-Touch Attribution

A candidate may interact with several sourcing channels before being hired. The platform compares three attribution approaches:

- **First-touch:** assigns the hire's credit to the first recorded source.
- **Last-touch:** assigns the credit to the last recorded source.
- **Linear:** distributes credit equally across the recorded touchpoints.

Comparing these models helps show how the perceived contribution of a source changes depending on the attribution rule.

### 4. Hiring Time Analysis

Analyze time-to-hire for candidates with valid hire dates. The report can compare average and median time-to-hire, hiring trends over time, and hiring speed by source or other available candidate attributes.

Candidates who were not hired should not be assigned an artificial time-to-hire value.

### 5. Interactive Power BI Reporting

The reports bring together KPI cards, funnel and drop-off visuals, monthly trends, source comparisons, attribution comparisons, and cost-efficiency analysis. Slicers allow users to explore the data by supported dimensions such as year, role, source, or location.

## KPIs and Business Metrics

| KPI | Definition |
|---|---|
| Total Candidates | Distinct candidates in the selected population |
| Total Hires | Distinct candidates who reached the hired outcome |
| Stage Conversion Rate | Candidates reaching a stage ÷ candidates in the defined preceding population |
| Stage Drop-off Rate | Candidates lost between consecutive stages ÷ candidates entering the earlier stage |
| Offer Acceptance Rate | Accepted offers or hires ÷ offers, according to the project's defined event logic |
| Average Time-to-Hire | Average elapsed days between the defined start date and hire date for hired candidates |
| Median Time-to-Hire | Median elapsed days for hired candidates |
| Cost per Hire | Source spend ÷ hires, using the explicitly selected source-credit rule |
| Cost per Attributed Hire | Source spend ÷ attributed hires |
| Attributed Hires | Sum of source-level attribution credits under a selected model |

**Metric definitions matter.** For example, an offer acceptance rate should be calculated as accepted offers divided by offers—not as the hired segment's percentage of a donut chart containing both offered and hired counts. Similarly, cost-per-hire results depend on how source spend and hires are attributed.

## Multi-Touch Attribution

Example journey:

```text
LinkedIn -> Career Site -> Referral -> Hired
```

Illustrative linear credit for three recorded touchpoints:

| Source | Linear credit |
|---|---:|
| LinkedIn | 0.333 |
| Career Site | 0.333 |
| Referral | 0.333 |
| **Total** | **1.000** |

This example illustrates the method; it is not a measured result from the dataset.

Attribution is a rule for distributing credit, not proof that a channel caused a hire. The model is useful for comparing sourcing journeys, but it should be interpreted alongside spend, conversion, and hiring outcomes.

## Power BI Dashboards

The report is designed to support analysis across the following areas:

- **Recruitment Funnel:** candidate counts and progression across stages.
- **Sourcing ROI & Attribution:** source costs, cost per hire or attributed hire, and first-touch vs. last-touch vs. linear attribution.
- **Hiring Time Analysis:** average and median time-to-hire, monthly hiring trends, source comparisons, and target-versus-actual hiring time.

Add screenshots of your completed report to this README when available. For example, create a `screenshots/` folder and place exported dashboard images in it, then embed them with Markdown:

```markdown
![Recruitment Funnel Dashboard](screenshots/recruitment-funnel.png)
![Sourcing ROI Dashboard](screenshots/source-roi.png)
![Hiring Time Analysis](screenshots/hiring-time-analysis.png)
```

Only keep image links for screenshots that you have actually added to the repository.

## Data and Assumptions

- The project uses **synthetic data** for portfolio demonstration; results should not be treated as real-world recruitment benchmarks.
- Candidate, event, touchpoint, and source-cost data serve different analytical purposes and should be joined using appropriate keys.
- Missing hire dates are expected for candidates who were not hired.
- Funnel counts, conversion rates, and attribution results depend on consistent stage definitions and deduplication rules.
- Source costs must match the time period and level of granularity used by the ROI calculation. If costs are monthly but hires span multiple periods, the cost model should be interpreted accordingly.

## Getting Started

### Prerequisites

Install or configure:

- Python 3
- PostgreSQL
- dbt Core with the PostgreSQL adapter
- Power BI Desktop
- Git (optional, for cloning the repository)

### 1. Clone the repository

```bash
git clone https://github.com/Riya-712/Hiring_Analytics_platform.git
cd Hiring_Analytics_platform
```

### 2. Set up Python

Create and activate a virtual environment:

**Windows PowerShell**
```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
```

Install the packages listed in the project's dependency file, if one is provided:

```bash
pip install -r requirements.txt
```

If the repository does not contain a `requirements.txt`, install the packages required by the data-generation and cleaning scripts, such as pandas, in your environment.

### 3. Prepare the data

Run the project's data-generation and/or cleaning scripts as appropriate for the files included in the repository. Confirm that the expected CSV files have been created and inspect their column names, row counts, date fields, keys, and null values before loading them.

### 4. Load data into PostgreSQL

Create or select the PostgreSQL database configured in your dbt profile. Load the cleaned CSV files into the raw tables expected by the dbt source definitions and models. The table names and column names must match the project's SQL models.

Do not commit database passwords or other credentials. Keep local connection details in your dbt profile or environment configuration, and ensure secrets are excluded from version control.

### 5. Configure dbt

From the directory containing `dbt_project.yml`, configure the PostgreSQL connection in your local `profiles.yml` and verify the connection:

```bash
dbt debug
```

The dbt profile name and target must match the settings in `dbt_project.yml`.

## Running dbt

Run these commands from the **dbt project directory**—the directory containing `dbt_project.yml`.

Check project configuration:

```bash
dbt debug
```

Inspect available models and resources:

```bash
dbt ls
```

Load configured seed CSV files, such as source-cost reference data:

```bash
dbt seed
```

Build the models:

```bash
dbt run
```

Run data-quality tests:

```bash
dbt test
```

For a combined build and test workflow, where supported by your installed dbt version:

```bash
dbt build
```

If a model is not found, check its SQL filename, whether the model is enabled, the configured model paths, and whether the command is being run from the correct directory. If a relation does not exist, check that its upstream source tables and dbt dependencies have been created successfully.

## Connect Power BI

1. Open Power BI Desktop.
2. Select **Get data → PostgreSQL database**.
3. Enter your PostgreSQL server and database.
4. Connect to the required dbt models or marts.
5. Verify data types and relationships.
6. Create or validate DAX measures against the SQL definitions.
7. Add slicers and visuals, and test whether filters produce consistent KPI values.

Prefer business-ready marts for reporting rather than duplicating complex business logic independently in multiple visuals.

## Project Structure

The exact file layout may vary as the project evolves. Conceptually, the repository contains these components:

```text
Hiring_Analytics_platform/
├── data/                 # Generated or cleaned CSV files, if included
├── models/
│   ├── staging/          # Standardized source models
│   ├── intermediate/     # Reusable transformations, if present
│   └── marts/            # Hiring, attribution, and ROI models
├── seeds/                # Static reference CSVs, such as source costs
├── dbt_project.yml       # dbt project configuration
├── profiles.yml          # Local connection configuration; do not commit secrets
├── requirements.txt      # Python dependencies, if included
└── README.md
```

This is a conceptual guide, not a guarantee that every listed directory or file exists in the current repository. Use the actual repository tree as the source of truth.

## Limitations and Future Enhancements

- Replace synthetic data with appropriately governed ATS and recruitment-marketing data.
- Add automated pipeline scheduling and monitoring.
- Expand source-cost modelling to campaign-level or monthly spend where data is available.
- Add more data tests for referential integrity, valid stage sequences, and metric reconciliation.
- Implement and validate a controlled A/B testing module before reporting experimental results.
- Add documentation and screenshots for each Power BI report page.

## Author

**Riya Raut**

- GitHub: [Riya-712](https://github.com/Riya-712)
- Project repository: [Hiring Analytics Platform](https://github.com/Riya-712/Hiring_Analytics_platform)

---

*This project is for educational and portfolio purposes. All analytical findings should be interpreted in the context of the synthetic data and documented metric definitions.*
