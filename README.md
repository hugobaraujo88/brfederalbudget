# Project: Federal Government Budget | Overview

This project aims to extract and analyze data from the federal budget, presenting it in an accessible and informative format through an interactive dashboard. **The goal is to enable quick and integrated analysis, making it easier to understand how the federal government's resources are collected and allocated.**

This video https://youtu.be/dawEcPuuV1s contains a brief description of the project and its architecture, **along with the real-time recording of the running project pipelines.** 

## Project Architecture (high level)

![Architecture high level](https://raw.githubusercontent.com/hugobaraujo88/brfederalbudget/main/img/transparencia_data_arch.png)

**1)** Data is extracted from the Transparency Portal - transparencia.gov shown - of the CGU (Brazilian Comptroller General's Office): Executed Expenses, Budgeted Expenses (the planned budget), Expected and Collected Revenue

**2)** Data is extracted from the IBGE (Brazilian Institute of Geography and Statistics) website: Quarterly GDP.

**3)** Extracted data is stored in Azure Data Lake.

**4)** The raw data extracted from the Transparency Portal are transformed using PySpark in the Databricks environment. This transformation includes renaming columns, removing unnecessary columns, creating numeric columns (float and int), and performing some data splits on the raw data.

**5)** The raw data extracted from the IBGE is transformed using Data Flow (which also uses a Spark cluster). The transformation primarily involves converting the quarterly GDP into an annual format.

**6)** Processed data is loaded into an Azure SQL database. (The schema and table structures were created using the following code: [create_SQL_schema.py](https://github.com/hugobaraujo88/brfederalbudget/blob/main/create_SQL_schema.py) )

**7)** Historical data from 2014 to 2023 is extracted, processed, and sent to Azure SQL using a Python script. (kindly review this file [download_orcamento_federal.py](https://github.com/hugobaraujo88/orcamentogovfed/blob/main/download_orcamento_federal.py) and this [send_historical_to_sql.py](https://github.com/hugobaraujo88/brfederalbudget/blob/main/send_historical_to_sql.py))

**8)** Finally, after running the queries located in the [SQL Scripts](https://github.com/hugobaraujo88/brfederalbudget/tree/main/SQL%20Scripts) folder, which are automatically executed each time the loading pipeline is triggered, he dashboard is created in Power BI via direct query.

## Dashboard

![dashboard](https://raw.githubusercontent.com/hugobaraujo88/brfederalbudget/main/img/printDashboard.png)

Download of the dashboard that uses direct query with the Azure SQL database (PBIX file for opening in Power BI): [Orçamento Do Governo Federal - Panorama - Azure](https://github.com/hugobaraujo88/brfederalbudget/raw/main/Dashboard%20Power%20BI/OrcamentoGovernoFederalPanorama%20-%20azure.pbix).

Download of the dashboard without the Azure infrastructure, featuring imported and updated data up to September 2023 (PBIX file for opening in Power BI): [Orçamento Do Governo Federal - Panorama](https://github.com/hugobaraujo88/brfederalbudget/raw/main/Dashboard%20Power%20BI/OrcamentoGovernoFederalPanorama.pbix).


## Project requirements

**-** Python + libs (`requests`, `pandas`, `textwrap`, `textwrap`, `pyodbc`, `sqlalchemy`, `zipfile`, `os`, `urllib.parse`) 

**-** .ipynb file reader, such as jupyter (Data Exploratory Analysis [analise_exploratoria.ipynb](https://github.com/hugobaraujo88/brfederalbudget/blob/main/analise_exploratoria.ipynb))

**-** Azure Subscription

## Templates Azure

The [Templates - Azure](https://github.com/hugobaraujo88/brfederalbudget/tree/main/Templates%20-%20Azure) folder contains JSON-formatted codes for all Azure services and objects used, as well as detailed architectures for each project pipeline. These codes enable project replication within any Azure subscription.

To download the repository, use the following commands with Git Bash in any folder:

```
git init

git clone https://github.com/hugobaraujo88/brfederalbudget
```

## Estimated Costs

The following table presents an estimate of costs (in US dollars) for orchestration, execution, and storage for project maintenance. The total value is monthly. (Pipelines triggered once per month). 

| Resource/Service                                | Quantity | Unit           | Unit Cost (US$) | Total   |
|----------------------------------------|----------|----------------|-----------------|---------|
| **Pipeline orchestration (Azure IR)**       |    |              |           |   |
| Activity Runs                               | 34.00    | UN             | 0.001           | 0.034   |
| **Pipeline execution (Azure IR)**           |          |                |                 |         |
| Data movement activities              | 0.600    | DIU-hour       | 0.25            | 0.150   |
| Pipeline activities                   | 0.283    | Execution hours| 0.00025         | 0.0000715 |
| External activities (DataBricks)      | 0.100    | DBU-hour       | 1.50            | 0.150   |
| General purpose (Data Flow)             | 0.405    | vCore-hour     | 2.29            | 0.927   |
| **Azure SQL**                               |          |                |                 |         |
| Basic Storage                         | 5.00     | DTU            | 1.19            | 5.950   |
| **Azure Data Lake Store Gen2**              |          |                |                 |         |
| LRS Hot Storage                       | 0.11     | GB             | 0.02            | 0.002   |
| **Total (US$)**                            |          |                |                 | **7.21**    |
