import azure.functions as func
import logging

from table_helper import TableServiceHelper

app = func.FunctionApp()

@app.route(route="ping", auth_level=func.AuthLevel.ANONYMOUS)
def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Ping recieved')

    name = req.params.get('name') 
    if not name: 
        try: 
            req_body = req.get_json() 
        except ValueError: 
            pass 
        else: 
            name = req_body.get('name') 
            
    if name: 
        return func.HttpResponse( 
            f"Hello, {name}. Pong!",
            status_code=200
        )
        
    return func.HttpResponse(
        "Pong!",
        status_code=200
    )

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
