import AWS, { DynamoDB } from "aws-sdk";
import jsonwebtoken from 'jsonwebtoken';

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
        const TOKEN_KEY = process.env.TOKEN_KEY || ""
        var body = JSON.parse(event.body);
        const name = body.name;
        const firstName = body.firstName;
        const email = body.email;
        const adresse = body.adresse;

        var params = {
            TableName: DB,
            Key: {
                email: email
            },
            UpdateExpression: "set #newName = :name, firstName = :firstName, adresse = :adresse ",
            ExpressionAttributeValues: {
                ":name": name,
                ":firstName": firstName,
                ":adresse": adresse
            },
            ExpressionAttributeNames: {
                "#newName": "name",
            },
        };

        await docClient.update(params).promise()


        return messageReturn(200, "Mise à jour réussie")
    }
    catch (e) {
        return messageReturn(404, e)
    }

}