# Input: Items you wish to scrape for and find the price. Input syntax {"items": [ "items" ] }
# Output: 200 Status Code. Adds these items to the table with scraped information. Also checks if the items are already in the table
# we do not have to re scrape

import json
import random
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
db = dynamodb.Table("scrape_data")

def lambda_handler(event, context):
    # TODO implement
    
    
    print(event);
    
    for i in event['items']:
        print(i)
        
        # check if the item already exists in the table
        
        query_result = db.query(
            KeyConditionExpression = Key('item_name').eq(i)
        ) 
        
        query_result = query_result["Items"]
        print (query_result)
        
        # if it doesn't, add it to the table
        
        if (len(query_result) == 0):
            item = {
                "item_name": i,
                "amazon_price": random.randint(1,6),
                "walmart_price": random.randint(1,6)
            }
            
            db.put_item(
                Item=item)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
