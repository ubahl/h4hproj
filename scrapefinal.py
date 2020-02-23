import json
import random
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
db = dynamodb.Table("scrape_data")

def lambda_handler(event, context):
    # TODO implement
    
    print(event);
    
    item_name = event["item_name"]
    store = ""
    
    try:
        event["walmart_price"]
        store = "walmart"
    except:
        event["safeway_price"]
        store = "safeway"
        
    query_result = db.query(
        KeyConditionExpression = Key("item_name").eq(item_name)
    ) 
    
    print(query_result)
    
    query_result = query_result["Items"]
    
    # if this is a new item
    if (len(query_result) == 0):
        if (store == "safeway"):
            item = {
                "item_name": item_name,
                "safeway_price": event["safeway_price"],
                "walmart_price": "unknown" 
            }
        if (store == "walmart"):
            item = {
                "item_name": item_name,
                "safeway_price": "unknown",
                "walmart_price": event["walmart_price"] 
            }
      
    # else just change according to the input      
    else:
        item = {
            "item_name": item_name,
            "safeway_price": query_result[0]["safeway_price"],
            "walmart_price": query_result[0]["walmart_price"]
        }
        if (store == "safeway"):
            item["safeway_price"] = event["safeway_price"]
        else:
            item["walmart_price"] = event["walmart_price"]
            
    
    db.put_item(
        Item=item)
    
    # for i in event['items']:
    #     print(i)
        
    #     # check if the item already exists in the table
        
    #     query_result = db.query(
    #         KeyConditionExpression = Key('item_name').eq(i)
    #     ) 
        
    #     query_result = query_result["Items"]
    #     print (query_result)
        
    #     # if it doesn't, add it to the table
        
    #     if (len(query_result) == 0):
    #         item = {
    #             "item_name": i,
    #             "amazon_price": random.randint(1,6),
    #             "walmart_price": cheapest  # actually 
    #         }
            
    #         db.put_item(
    #             Item=item)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
