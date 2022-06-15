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

exports.handler = async (event: any) => {
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
            if (result.Item.password.S === password) {
                const token = jwt.sign({ exp: Math.floor(Date.now() / 1000) + (60 * 60 * 24) }, TOKEN_KEY)
                console.log("yyyyyy")
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

                var paramsGet = {
                    TableName: 'user',
                    Key: {
                        'email': { S: email }
                    },
                    ProjectionExpression: 'email, isAdmin, isActif, #newName, firstName, adresse, concert',
                    ExpressionAttributeNames: {
                        '#newName': 'name'
                    }
                };
                var data = await ddb.getItem(paramsGet).promise();

                var user = {}
                if (data.Item !== undefined) {
                    const newUser = { email: data.Item.email.S, isAdmin: data.Item.isAdmin.BOOL, isActif: data.Item.isActif.BOOL, name: data.Item.name.S, firstName: data.Item.firstName.S, adresse: data.Item.adresse.S, concert: data.Item.concert.S }
                    user = newUser;
                }

                return messageReturn(200, JSON.stringify(user));
            }
            else {
                return messageReturn(400, "Aucun utilisateur trouvé")
            }

        }

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}