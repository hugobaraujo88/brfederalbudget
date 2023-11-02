# Pipeline Architecture: pl_extract_transparenciagov

![pl_extract_transparenciagov](https://raw.githubusercontent.com/hugobaraujo88/brfederalbudget/main/img/pl_extract_transparenciagov.drawio.png)

**1)** **Dataset:** *ds_sourcedatalake_json_lookup* (dataset for json file reading: readurls.json)

**2)** **Linked service:** *ls_datalake*

**3)** **Dataset:** *ds_sourcehttp_transparenciagov* (Dataset for extracting files, in .zip format, from the transparency website )

**4)** **Linked service:** *ls_http_transparenciagov*

**5)** **Dataset:** *ds_sinkdatalake_zip_transparenciagov* (Dataset for storing files, in .zip format, in Azure Data Lake)

**6)** **Linked service:** *ls_datalake*

**7)** **Dataset:** *ds_sourcedatalake_zip_transparenciagov* (Dataset for extracting .csv files from the .zip archives)

**8)** **Linked service:** *ls_datalake*

**9)** **Dataset:** *ds_sinkdatalake_csv_transparenciagov* (Dataset to load the data lake with .csv files originated from .zip ones)

**10)** **Linked service:** *ls_datalake*

# Data Factory View

![pl_extract_transparenciagov1](https://raw.githubusercontent.com/hugobaraujo88/brfederalbudget/main/img/pl_extract_transparenciagov1.png)


![pl_extract_transparenciagov2_foreach](https://raw.githubusercontent.com/hugobaraujo88/brfederalbudget/main/img/pl_extract_transparenciagov2_foreach.png)
