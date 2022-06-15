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

        var params = {
            Bucket: S3,
            Delimiter: '/',
            Prefix: 'Musique/'
        }

        const fichiers = await s3.listObjects(params).promise();
        if (fichiers.Contents !== undefined) {
            var tab = []
            for (var i = 0; i < fichiers.Contents.length; i++) {
                console.log(fichiers.Contents[i])
                if (fichiers.Contents[i] !== undefined) {
                    if (fichiers.Contents[i].Key !== undefined) {
                        var res = fichiers.Contents[i].Key || ""
                        tab.push(res.replace('Musique/', ''))
                    }
                }
            }
            console.log(fichiers.Contents)
            return messageReturn(200, JSON.stringify({ "value": tab }));
        }
        else
            return messageReturn(200, 'fichier.Contents undefined');

    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}