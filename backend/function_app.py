import azure.functions as func
import logging

from table_helper import TableServiceHelper

app = func.FunctionApp()
    
@app.route(route="count", auth_level=func.AuthLevel.ANONYMOUS)
def GetVisitorCount(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Getting visitor count from CosmosDB')
    table_service_helper = TableServiceHelper()
    count = table_service_helper.get_visitor_count()
    return func.HttpResponse(
        "{}".format(count),
        status_code=200
    )

@app.route(route="increment", auth_level=func.AuthLevel.ANONYMOUS)
def IncrementVisitorCount(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Incrememnting visitor count in CosmosDB')

    table_service_helper = TableServiceHelper()
    count = table_service_helper.get_visitor_count()
    try:
        table_service_helper.upsert_visitor_count(count + 1)
        return func.HttpResponse(
            "{}".format(count + 1),
            status_code=200
        )
    except Exception as error:
        logging.error("An error occurred incrementing visitor count. Error = {}".format(error))
        return func.HttpResponse(
            "An error occurred incrementing visitor count. Error = {}".format(error),
            status_code=500
        )