import AWS from "aws-sdk";
import moment from 'moment'
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
        const TOKEN_KEY = process.env.TOKEN_KEY || ""
        const S3 = process.env.BUCKET || ""

        var param = {
            Bucket: S3,
            Key: event.key
        };
        const r = await s3.getObject(param).promise();
        if (r.Body !== undefined)
            return messageReturn(200, r.Body.toString('utf-8'));
        else
            return messageReturn(404, "Fichier non trouvé")

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}