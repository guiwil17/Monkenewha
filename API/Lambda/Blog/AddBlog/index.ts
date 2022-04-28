import AWS from "aws-sdk";

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
        const titre = body.titre;
        const date = body.date;
        const description = body.description;
        const img = body.img;
        const timestamp = body.timestamp;

        const item = {
            TableName: DB,
            Item: {
                id: { S: timestamp },
                titre: { S: titre },
                date: { S: date },
                description: { S: description },
                img: { S: img },
            },
            ConditionExpression: 'attribute_not_exists(id)',
        };
        await ddb
            .putItem(item)
            .promise()

        return messageReturn(200, "ajout de l'article fini")

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}