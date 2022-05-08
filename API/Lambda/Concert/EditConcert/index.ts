import AWS from "aws-sdk";

const ddb = new AWS.DynamoDB({ region: "eu-west-3" });
var docClient = new AWS.DynamoDB.DocumentClient()
const s3 = new AWS.S3();

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
        const description = body.description;


        const ajout_s3 = {
            Bucket: "monkenewha",
            Key: "Concert/" + id,
            Body: img,

        }

        await s3.putObject(ajout_s3).promise()

        var params = {
            TableName: DB,
            Key: {
                id: id
            },
            UpdateExpression: "set lieu = :lieu, date = :date, nbrPlace = :nbrPlace, description = :description ",
            ExpressionAttributeValues: {
                ":lieu": lieu,
                ":date": date,
                ":nbrPlace": nbrPlace,
                ":description": description,
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