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

        const lieu = body.lieu;
        const date = body.date;
        const nbrPlace = body.nbrPlace;
        const img = body.img;
        const nbrPlaceDispo = body.nbrPlaceDispo;
        const timestamp = body.timestamp;

        const item = {
            TableName: DB,
            Item: {
                id: { S: timestamp },
                lieu: { S: lieu },
                date: { S: date },
                nbrPlace: { S: nbrPlace },
                img: { S: img },
                nbrPlaceDispo: { S: nbrPlaceDispo }
            },
            ConditionExpression: 'attribute_not_exists(id)',
        };
        await ddb
            .putItem(item)
            .promise()

        return messageReturn(200, "ajout fini")

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}