import os
import pandas as pd


class Extractor:
    def __init__(self,datadir:str):
        self.data_directory = datadir

    def load_file(self,file_name:str)-> pd.DataFrame:
        file_path = os.path.join(self.data_directory,file_name)
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"ERROR : CSV File : {file_path} does not exist !")
        try:
            return pd.read_csv(file_path,dtype=str)
        except UnicodeError as e:
            raise ValueError(f"Unicode encoding error in '{file_path}': {e}") from e

        
    def explore_data(self,df:pd.DataFrame, file_name:str, primary_key:str,key_composite:str=None):
        print(f"============ FILE: {file_name}:{df.shape}=================")
        print(df.head(2).T)
        print(df.dtypes)
        if primary_key in df.columns:
            if df[primary_key].is_unique :
                print(f"{primary_key} is unique (primary key)")
            else :
                duplicated_raws = df.duplicated().sum()
                print(f"{primary_key} is duplicated, Duplicated raws = {duplicated_raws}")
        if key_composite in df.columns:
            if df.duplicated(subset=[primary_key,key_composite]).sum()==0:
                print(f"{primary_key} and {key_composite} is the composite primary key !")

        print(f"NULL values \n {df.isnull().sum()}")

        

 