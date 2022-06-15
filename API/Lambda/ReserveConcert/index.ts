import AWS, { DynamoDB } from "aws-sdk";
import jsonwebtoken from 'jsonwebtoken';

const ddb = new AWS.DynamoDB({ region: "eu-west-3" });
var docClient = new AWS.DynamoDB.DocumentClient()


type tResponse = {
    statusCode: number;
    body: string
    headers: {}
};

function messageReturn(code: number, message: any): tResponse {
    if (code === 200) {
        var status = "ok";
    } else {
        status = "error";
    }
    return {
        statusCode: code,
        body: JSON.stringify({
            status: status,
            response: message,
        }),
        headers: {
            'Access-Control-Allow-Origin': '*'
        },
    };
}

exports.handler = async (event: any) => {
    try {
        const DB = process.env.DYNAMO_DB || ""
        var body = JSON.parse(event.body);
        const email = body.email;
        const concerts = body.concerts;
        const idConcert = body.idConcert;
        const placePrise = body.placePrise;

        var paramsGet = {
            TableName: 'concert',
            Key: {
                'id': { S: idConcert }
            },
            ProjectionExpression: 'id, nbrPlaceDispo'
        };
        var data = await ddb.getItem(paramsGet).promise();

        if (data.Item !== undefined) {
            if (data.Item.nbrPlaceDispo.S !== undefined) {
                if (parseInt(data.Item.nbrPlaceDispo.S) !== 0 && parseInt(data.Item.nbrPlaceDispo.S) - placePrise >= 0) {
                    var paramsConcert = {
                        TableName: "concert",
                        Key: {
                            id: idConcert
                        },
                        UpdateExpression: "set nbrPlaceDispo = :nbrPlaceDispo ",
                        ExpressionAttributeValues: {
                            ":nbrPlaceDispo": parseInt(data.Item.nbrPlaceDispo.S) - placePrise,
                        },
                    };


                    await docClient.update(paramsConcert).promise()
                }
            }
        }

        var params = {
            TableName: "user",
            Key: {
                email: email
            },
            UpdateExpression: "set concert = :concert ",
            ExpressionAttributeValues: {
                ":concert": concerts,
            },
        };

        await docClient.update(params).promise()



        return messageReturn(200, "ajout fini")
    }
    catch (e) {
        return messageReturn(404, e)
    }

}