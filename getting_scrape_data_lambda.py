# This lambda accesses the database with all the price information and returns JSON
# Input: a POST request to the endpoint with all the items you want the prices of {"items": [ "all the strings" ] }
# Output: JSON with the amazon_price, walmart_price, and item_name

import json
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
db = dynamodb.Table("scrape_data")

def lambda_handler(event, context):
    # TODO implement
    
    result = []
    
    print(event)
    for i in event['items']:
        
        query_result = db.query(
            KeyConditionExpression = Key('item_name').eq(i)
        ) 
        
        try:
            query_result = query_result['Items'][0]
            
            wal_price = str(query_result['walmart_price'])
            amazon_price = str(query_result['amazon_price'])
            
            query_result['walmart_price'] = wal_price
            query_result['amazon_price'] = amazon_price
        
            result.append(query_result)
        except:
            print("no such item")
    
    
    print ("result ", result)
    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }
