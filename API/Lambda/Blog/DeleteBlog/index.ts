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
        const DB = process.env.DYNAMO_DB || ""

        const id = event.id;

        const ajout_s3 = {
            Bucket: "monkenewha",
            Key: "Blog/" + id,
        }

        await s3.deleteObject(ajout_s3).promise()

        var params = {
            TableName: DB,
            Key: {
                "id": id
            }
        };

        await docClient.delete(params).promise()
        return messageReturn(200, "Suppression de l'article fini")

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}