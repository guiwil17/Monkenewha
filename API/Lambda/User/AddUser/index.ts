import AWS, { DynamoDB } from "aws-sdk";


const ddb = new AWS.DynamoDB({ region: "eu-west-3" });

type tResponse = {
    statusCode: number;
    body: string
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

exports.handler = async (event: { body: any }, context: any, callback: any) => {
    try {
        const DB = process.env.DYNAMO_DB || ""
        var body = JSON.parse(event.body);
        const name = body.name;
        const email = body.email;
        const password = body.password;
        const firstName = body.firstName;
        const item: DynamoDB.PutItemInput = {
            TableName: DB,
            Item: {
                email: { S: email },
                name: { S: name },
                firstName: { S: firstName },
                password: { S: password },            
                isAdmin: { BOOL: false }
            },
            ConditionExpression: 'attribute_not_exists(email)',
        };
        await ddb
            .putItem(item)
            .promise()

        return messageReturn(200, "ajout fini")
    }
    catch (e) {
        return messageReturn(404, e)
    }

}