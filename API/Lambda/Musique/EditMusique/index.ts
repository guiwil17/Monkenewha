import AWS from "aws-sdk";

const s3 = new AWS.S3();

const ddb = new AWS.DynamoDB({ region: "eu-west-3" });
var docClient = new AWS.DynamoDB.DocumentClient()

type tResponse = {
    statusCode: number;
    body: string;
    headers: {}
};

const objectType = "application/json";


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
        const S3 = process.env.BUCKET || ""
        const DB = process.env.DYNAMO_DB || ""

        var body = JSON.parse(event.body);

        const key = body.key;
        const titre = body.titre;
        const date = body.date;
        const img = body.img;
        const morceau = body.morceau;

        const ajout_s3 = {
            Bucket: S3,
            Key: key,
            Body: morceau,
            ContentType: objectType

        }

        await s3.putObject(ajout_s3).promise()

        var params = {
            TableName: DB,
            Key: {
                id: key
            },
            UpdateExpression: "set titre = :titre, date = :date, img = :img ",
            ExpressionAttributeValues: {
                ":titre": titre,
                ":date": date,
                ":img": img,
            },
        };

        await docClient.update(params).promise()

        return messageReturn(200, "Modification de l'article fini")

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}