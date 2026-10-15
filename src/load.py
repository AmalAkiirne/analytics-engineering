from google.cloud import bigquery
import pandas as pd
from google.api_core.exceptions import GoogleAPIError


class LoadToBigquery:
    def __init__(self,projectId:str,datasetId:str):
        self.bq_projectId = projectId
        self.bq_datasetId = datasetId
        self.bq_client = bigquery.Client(projectId)

    def loadDfToBQ(self,df:pd.DataFrame,table_name:str):
        table_id=f"{self.bq_projectId}.{self.bq_datasetId}.{table_name}"
        try:
            job_config = bigquery.LoadJobConfig(
                write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE)
            
            job = self.bq_client.load_table_from_dataframe(
                df,
                table_id,
                job_config
            )
            job.result()
            print(f"{table_id} loaded in bigquery.")
        except GoogleAPIError as e:
            print(f"Google BigQuery ERROR:{type(e).__name__} : {e}")
        except Exception as e:
         
            print(f"Error: {type(e).__name__}: {e}")

    def loadCSVToBQ(self,csv_file_path:str,table_name:str):
        table_id=f"{self.bq_projectId}.{self.bq_datasetId}.{table_name}"
        try:
            job_config = bigquery.LoadJobConfig(
                source_format=bigquery.SourceFormat.CSV, skip_leading_rows=1, autodetect=True,
                write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE
                )

            with open(csv_file_path, "rb") as source_file:
                job = self.bq_client.load_table_from_file(source_file, table_id, job_config=job_config)
            
            job.result()
            print(f"{table_id} loaded in bigquery.")
        except GoogleAPIError as e:
            print(f"Google BigQuery ERROR:{type(e).__name__} : {e}")
        except Exception as e:
            print(f"Error: {type(e).__name__}: {e}")



