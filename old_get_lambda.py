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
        print (i)
        
        query_result = db.query(
            KeyConditionExpression = Key('item_name').eq(i)
        ) 
        
        print (query_result)
        try:
            query_result = query_result['Items']
            
            print(query_result)
            
            query_result = query_result[0]
            
            walmart_price = str(query_result['walmart_price'])
            
            print (walmart_price)
            
            safeway_price = str(query_result['safeway_price'])
            print(safeway_price)
            
            query_result['walmart_price'] = walmart_price
            
            print(query_result)
            query_result['safeway_price'] = safeway_price
            
            print(query_result)
        
            result.append(query_result)
        except:
            print("no such item")
    
    
    print ("result ", result)
    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }
