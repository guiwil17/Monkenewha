import AWS from "aws-sdk";
import moment from 'moment'
const s3 = new AWS.S3();

const ddb = new AWS.DynamoDB({ region: "eu-west-3" });

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

        // const params = {
        //     TableName: "musique",
        //     AttributesToGet: ['id', 'date', 'img', 'musique', 'titre']
        // };

        console.log(event.id)
        var params = {
            TableName: 'musique',
            Key: {
                'id': { S: event.id }
            },
            ProjectionExpression: 'id, #newDate, img, musique, titre, description',
            ExpressionAttributeNames: {
                '#newDate': 'date'
            }
        };
        var data = await ddb.getItem(params).promise();

        if (data.Item !== undefined) {
            const newObject = { id: data.Item.id.S, titre: data.Item.titre.S, description: data.Item.description.S, date: data.Item.date.S, img: "", musique: "" }
            try {
                var param = {
                    Bucket: "monkenewha",
                    Key: "Musique/" + newObject.id
                };
                const r = await s3.getObject(param).promise();
                console.log("la")
                if (r.Body !== undefined) {
                    console.log("ici")
                    newObject.musique = r.Body.toString('utf-8')
                }
                var param_jaquette = {
                    Bucket: "monkenewha",
                    Key: "Musique/Jaquette/" + event.id
                };
                const jaquette = await s3.getObject(param_jaquette).promise();
                console.log("la")
                if (jaquette.Body !== undefined) {
                    console.log("ici")
                    newObject.img = jaquette.Body.toString('utf-8')
                    console.log(jaquette.Body.toString('utf-8'))
                }
            }
            catch (e) {
            }
            console.log(JSON.stringify(newObject.img))
            console.log("ici")
            return messageReturn(200, JSON.stringify({ musique: newObject }));

        }
    }
    catch (e) {
        console.log(e)
        return messageReturn(400, e)
    }
}