import AWS from "aws-sdk";
import jwt from 'jsonwebtoken'

const ddb = new AWS.DynamoDB({ region: "eu-west-3" });
var docClient = new AWS.DynamoDB.DocumentClient()

type tResponse = {
    statusCode: number;
    body: string;
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

exports.handler = async (event: { body: any }, context: any, callback: any) => {
    try {
        const TOKEN_KEY = process.env.TOKEN_KEY || ""
        const DB = process.env.DYNAMO_DB || ""
        var body = JSON.parse(event.body);
        const email = body.email;

        const token = jwt.sign({ exp: Math.floor(Date.now() / 1000) + (10), data: Math.random().toString(36).substr(2, 5) + String(Math.round(+new Date() / 1000)) }, TOKEN_KEY)

        const UpdateParams = {
            TableName: DB,
            Key: {
                email: email,
            },
            UpdateExpression: "set userToken = :token",
            ExpressionAttributeValues: {
                ":token": token,
            }
        }
        await docClient.update(UpdateParams).promise()
        return messageReturn(200, "Déconnecté")
    }
    catch (e) {
        return messageReturn(404, e)
    }
}