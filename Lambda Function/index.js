console.log('2017 @Be9Concepts');
console.log('Loading event');
var AWS = require('aws-sdk');
var dynamodb = new AWS.DynamoDB();

exports.handler = function(event, context) {
    console.log("Request received:\n", JSON.stringify(event));
    console.log("Context received:\n", JSON.stringify(context));

    var operation = event.operation;
    console.log(operation);

    var tableName = "SeleniumDB";
    var datetime = new Date().getTime().toString();
    if (operation == "PUT"){
    dynamodb.putItem({
            "TableName": tableName,
            "Item": {
                "ID": {
                    "N": event.id
                },
                "timedate": {
                    "N": datetime
                },
                "state": {
                    "N": event.state
                },
                "command": {
                    "S": event.command
                }
            }
        }, function(err, data) {
            if (err) {
                context.fail('ERROR: Dynamo failed: ' + err);
            } else {
                console.log('Dynamo Success: ' + JSON.stringify(data, null, '  '));
                context.succeed('SUCCESS');
            }
        });
    }
    else if (operation == "GET"){
        dynamodb.getItem({
          Key: {
            "ID": {
              N: "101"
            }
          },
          TableName: tableName
        }, function(err, data) {
          if (err) {
              console.log(err, err.stack); // an error occurred
              context.fail('ERROR: Dynamo failed: ' + err);
          }
          else {
              console.log(data);           // successful response
              context.succeed('GET Success: ID=' + data["Item"]["ID"]["N"] + ",Command=" +data["Item"]["command"]["S"] + ",State=" + data["Item"]["state"]["N"]);
          }
        });
    }
}
