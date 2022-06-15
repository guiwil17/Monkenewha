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
        const TOKEN_KEY = process.env.TOKEN_KEY || ""
        const DB = process.env.DYNAMO_DB || ""
        var body = JSON.parse(event.body);

        const titre = body.titre;
        const description = body.description;
        const img = body.img;
        const id = body.id;

        const ajout_s3 = {
            Bucket: "monkenewha",
            Key: "Blog/" + id,
            Body: img,

        }

        await s3.putObject(ajout_s3).promise()

        var params = {
            TableName: DB,
            Key: {
                id: id
            },
            UpdateExpression: "set titre = :titre, description = :description ",
            ExpressionAttributeValues: {
                ":titre": titre,
                ":description": description
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