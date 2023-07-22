import json
import os

from azure.data.tables import TableServiceClient
from dotenv import load_dotenv

load_dotenv(verbose=True)

class TableServiceHelper:

    def __init__(self, table_name=None, conn_str=None):
        self.table_name = table_name if table_name else os.getenv("table_name")
        self.conn_str = conn_str if conn_str else os.getenv("conn_str")
        self.table_service = TableServiceClient.from_connection_string(self.conn_str)
        self.table_client = self.table_service.get_table_client(self.table_name)

