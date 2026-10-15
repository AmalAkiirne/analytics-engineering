from src.extract import Extractor
import pandas as pd
from src.config import DATA_DIR,PROJECT_ID,DATASET
from src.load import LoadToBigquery
import os


def load_all_dataframes(data_dir:str,extractor:Extractor,loader:LoadToBigquery):
    for file_name in os.listdir(data_dir):
        if "olist" in file_name and file_name.endswith(".csv"):
            df = extractor.load_file(file_name)
            pieces = file_name.split("_")
            name_elements = [elm for elm in pieces if elm not in ["olist","dataset.csv"]]
            table_name = "_".join(name_elements)
            loader.loadDfToBQ(df,table_name)

def clean_reviews_csv(file_path) -> str:
    df = pd.read_csv(file_path,encoding='UTF-8')
    clean = df[["review_id","order_id","review_score","review_creation_date","review_answer_timestamp"]]
    output_file = file_path.replace(".csv","_clean.csv")
    clean.to_csv(output_file,index=False, encoding="utf-8")
    return output_file

def load_all_csv_files(data_dir:str,loader:LoadToBigquery):
    for file_name in os.listdir(data_dir):
        if "olist" in file_name and file_name.endswith(".csv"):
            file_path = os.path.join(data_dir,file_name)
            if "order_reviews" in file_name:
                file_path = clean_reviews_csv(file_path)
            pieces = file_name.split("_")
            name_elements = [elm for elm in pieces if elm not in ["olist","dataset.csv"]]
            table_name = "_".join(name_elements)
            loader.loadCSVToBQ(file_path,table_name)

def main():
    # extractor = Extractor(DATA_DIR)
             # orders
    # csv_f = "olist_orders_dataset.csv"
    # df = extractor.load_file(csv_f)
    # extractor.explore_data(df,csv_f,"order_id")

                # geolocation
    # csv_f = "olist_geolocation_dataset.csv"
    # df = extractor.load_file(csv_f)
    # extractor.explore_data(df,csv_f,"geolocation_zip_code_prefix")

            # customers
    # csv_f = "olist_customers_dataset.csv"
    # df = extractor.load_file(csv_f)
    # extractor.explore_data(df,csv_f,"customer_unique_id")

                # order items
    # csv_f = "olist_order_items_dataset.csv"
    # df = extractor.load_file(csv_f)
    # extractor.explore_data(df,csv_f,"order_id","order_item_id")

            # order payment
    # csv_f = "olist_order_payments_dataset.csv"
    # df = extractor.load_file(csv_f)
    # print(df.loc[df['payment_sequential'] > 1, ['order_id', 'payment_sequential']])
    # extractor.explore_data(df,csv_f,"order_id","payment_sequential")

                # order reviews
    # csv_f = "olist_order_reviews_dataset.csv"
    # df = extractor.load_file(csv_f)
    # extractor.explore_data(df,csv_f,"review_id","order_id")

    #                 #  products
    # csv_f = "olist_products_dataset.csv"
    # df = extractor.load_file(csv_f)
    # extractor.explore_data(df,csv_f,"product_id")

    #                     #  sellers
    # csv_f = "olist_sellers_dataset.csv"
    # df = extractor.load_file(csv_f)
    # extractor.explore_data(df,csv_f,"seller_id")

    loader = LoadToBigquery(PROJECT_ID,DATASET)
    load_all_csv_files(DATA_DIR,loader)




if __name__ =="__main__" :
    main()

