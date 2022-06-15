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
        const token = body.token;
        const res = jsonwebtoken.verify(token, TOKEN_KEY);
        if (JSON.parse(JSON.stringify(res)).data.email) {

            var params = {
                TableName: DB,
                Key: {
                    email: JSON.parse(JSON.stringify(res)).data.email
                },
                UpdateExpression: "set isActif = :isActif ",
                ExpressionAttributeValues: {
                    ":isActif": true,
                },
            };

            await docClient.update(params).promise()


            return messageReturn(200, "Validation de l'email")
        }
        else {
            return messageReturn(200, "Erreur lors de la vérification")
        }
    }
    catch (e) {
        return messageReturn(404, e)
    }

}