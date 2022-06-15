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
        const password = body.password;

        if (body.actualPassword) {
            var paramsGet = {
                TableName: 'user',
                Key: {
                    'email': { S: email }
                },
                ProjectionExpression: 'email, password'
            };
            var data = await ddb.getItem(paramsGet).promise();

            if (data.Item !== undefined) {
                if (data.Item.password.S !== body.actualPassword) {
                    return messageReturn(400, "Mot de passe invalide")
                }
            }

        }

        var params = {
            TableName: DB,
            Key: {
                email: email
            },
            UpdateExpression: "set password = :password ",
            ExpressionAttributeValues: {
                ":password": password,
            },
        };

        await docClient.update(params).promise()



        return messageReturn(200, "ajout fini")
    }
    catch (e) {
        return messageReturn(404, e)
    }

}