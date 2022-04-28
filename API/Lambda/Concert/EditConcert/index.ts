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
        const id = body.id;

        var params = {
            TableName: "ucesorh",
            Key: {
                id: id
            },
            UpdateExpression: "set lieu = :lieu, date = :date, nbrPlace = :nbrPlace, img = :img ",
            ExpressionAttributeValues: {
                ":lieu": lieu,
                ":date": date,
                ":nbrPlace": nbrPlace,
                ":img": img,
            },
        };

        await docClient.update(params).promise()


        return messageReturn(200, "Modification fini")

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}