import json

import boto3


# Create CloudWatchEvents client
cloudwatch_events = boto3.client('events')

def lambda_handler(event, context):
    response = cloudwatch_events.put_events(
        Entries=[
            {
                'Source': 'user-event',
                'DetailType': 'request_to_process',
                'Detail': json.dumps({'key1': 'value1', 'key2': 'value2'}),
                'EventBusName': 'default',
            }
        ]
    )
    print(response['Entries'])

