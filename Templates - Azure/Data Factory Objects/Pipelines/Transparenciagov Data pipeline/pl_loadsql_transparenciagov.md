# Pipeline Architecture: pl_load_transparenciagov

![pl_extract_transparenciagov](https://raw.githubusercontent.com/hugobaraujo88/brfederalbudget/main/img/pl_loadsql_transparenciagov.drawio.png)

**1)** **Dataset:** *ds_sourcedatalake_getfoldernames* (dataset from the "get metadata" activity. It essentially reads the names of folders created after processing via pySpark)

**2)** **Linked service:** *ls_datalake*

**3)** **Dataset:** *ds_sourcedatalake_csv_processed* (dataset to get the transformed data lake from data lake)

**4)** **Linked service:** *ls_datalake*

**5)** **Dataset:** *ds_sinkasql_transparenciagov* (dataset to load the transformed data into Azure SQL)

**6)** **Linked service:** *ls_asql*

# Data Factory View

![pl_loadsql_transparenciagov](https://raw.githubusercontent.com/hugobaraujo88/brfederalbudget/main/img/pl_loadsql_transparenciagov.png)


![pl_loadsql_transparenciagov_foreach](https://raw.githubusercontent.com/hugobaraujo88/brfederalbudget/main/img/pl_loadsql_transparenciagov_foreach.png)