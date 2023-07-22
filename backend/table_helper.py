import os
from azure.data.tables import TableServiceClient
from dotenv import load_dotenv

load_dotenv()

class TableServiceHelper:

    def __init__(self, table_name=None, conn_str=None):
        self.table_name = table_name if table_name else os.getenv("table_name")
        self.conn_str = conn_str if conn_str else os.getenv("conn_str")
        self.table_service = TableServiceClient.from_connection_string(self.conn_str)
        self.table_client = self.table_service.get_table_client(self.table_name)
    
    def upsert_visitor_count(self, count = 1):
        params = {}
        params["PartitionKey"] = "statistic"
        params["RowKey"] = "visitor_count"
        params["count"] = count
        return self.table_client.upsert_entity(params)
    
    def get_visitor_count(self):
        result = self.table_client.get_entity("statistic", "visitor_count")
        return result["count"]
    
if __name__ == "__main__":
    table_service_helper = TableServiceHelper()
    count = table_service_helper.get_visitor_count()
    print(count)
    table_service_helper.upsert_visitor_count(count + 1)
    new_count = table_service_helper.get_visitor_count()
    print(new_count)
