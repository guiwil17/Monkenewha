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
        const DB = process.env.DYNAMO_DB || ""
        const params = {
            TableName: DB,
            AttributesToGet: ['id', 'titre', 'date', 'description', 'img']
        };

        var data = await docClient.scan(params).promise();

        var tab = []
        if (data.Items !== undefined) {

            for (var i = 0; i < data.Items.length; i++) {
                try {
                    var param = {
                        Bucket: "monkenewha",
                        Key: "Blog/" + data.Items[i].id
                    };
                    const r = await s3.getObject(param).promise();
                    if (r.Body !== undefined) {
                        data.Items[i].img = r.Body.toString('utf-8')
                    }
                    tab.push(data.Items[i])
                }
                catch (e) {
                    tab.push(data.Items[i])
                }
            }

            console.log(tab)

            return messageReturn(200, JSON.stringify({ blog: tab }));

        }
        else {
            return messageReturn(200, 'data.Items undefined');
        }

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}