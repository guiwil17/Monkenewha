import AWS from "aws-sdk";

const s3 = new AWS.S3();

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
        const TOKEN_KEY = process.env.TOKEN_KEY || "";
        const S3 = process.env.BUCKET || ""
        const DB = process.env.DYNAMO_DB || ""

        const key = event.key;


        var params = {
            Bucket: S3,
            Key: key
        }

        await s3.deleteObject(params)

        var param = {
            TableName: DB,
            Key: {
                "id": key
            }
        };

        await docClient.delete(param).promise()
        return messageReturn(200, "Suppresion de la musique fini")

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}