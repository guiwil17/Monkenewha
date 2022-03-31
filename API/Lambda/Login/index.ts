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
        const password = body.password;
        const params = {
            TableName: DB,
            Key: {
                email: { "S": email }
            }
        };
        const result = await ddb
            .getItem(params)
            .promise()



        if (result.Item !== undefined) {
            if (result.Item.password.S === password && result.Item.validationAdmin.BOOL === true && result.Item.validationEmail.BOOL === true) {
                const token = jwt.sign({ exp: Math.floor(Date.now() / 1000) + (60 * 60 * 24) }, TOKEN_KEY)
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

                const retour = {
                    token: token,
                    isAdmin: result.Item.isAdmin.BOOL,
                    role: result.Item.role.S,
                }

                return messageReturn(200, JSON.stringify(retour));
            }
            else {
                if (result.Item.validationAdmin.BOOL === false && result.Item.validationEmail.BOOL === true) {
                    return messageReturn(404, "Merci d'attendre la réponse de l'admin")
                }
                else if (result.Item.validationAdmin.BOOL === false && result.Item.validationEmail.BOOL === false) {
                    return messageReturn(404, "Merci de cliquer sur le lien du mail qui vous a été envoyé")
                }
                else {
                    return messageReturn(404, "erreur")
                }

            }
        }

    }
    catch (e) {
        return messageReturn(400, e)
    }
}