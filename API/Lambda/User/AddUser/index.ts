import AWS, { DynamoDB } from "aws-sdk";
import jsonwebtoken from 'jsonwebtoken';
import nodemailer from 'nodemailer';

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

exports.handler = async (event: any) => {
    try {
        const DB = process.env.DYNAMO_DB || ""
        const TOKEN_KEY = process.env.TOKEN_KEY || ""
        var body = JSON.parse(event.body);
        const name = body.name;
        const email = body.email;
        const password = body.password;
        const firstName = body.firstName;
        const adresse = body.adresse;
        const token = jsonwebtoken.sign({
            exp: Math.floor(Date.now() / 1000) + 60 * 60 * 24,
            data: {
                email: email,
                adresse: adresse,
                firstName: firstName,
                name: name
            },
        },
            TOKEN_KEY)

        var transporter = nodemailer.createTransport({
            service: 'Gmail',
            host: "smtp.gmail.com",
            auth: {
                user: 'noreply.monkenewha@gmail.com',
                pass: 'sarhibwxtfihlotp'
            }
        });

        console.log("ici")

        await new Promise((rsv, rjt) => {
            transporter.sendMail({
                from: 'noreply.monkenewha@gmail.com',
                to: email,
                subject: 'Création de compte Monkenewha',
                html: `
                <!DOCTYPE html>
<html>

<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style type="text/css">
    @media screen {
        @font-face {
            font-family: 'Lato';
            font-style: normal;
            font-weight: 400;
            src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v11/qIIYRU-oROkIk8vfvxw6QvesZW2xOQ-xsNqO47m55DA.woff) format('woff');
        }

        @font-face {
            font-family: 'Lato';
            font-style: normal;
            font-weight: 700;
            src: local('Lato Bold'), local('Lato-Bold'), url(https://fonts.gstatic.com/s/lato/v11/qdgUG4U09HnJwhYI-uK18wLUuEpTyoUstqEm5AMlJo4.woff) format('woff');
        }

        @font-face {
            font-family: 'Lato';
            font-style: italic;
            font-weight: 400;
            src: local('Lato Italic'), local('Lato-Italic'), url(https://fonts.gstatic.com/s/lato/v11/RYyZNoeFgb0l7W3Vu1aSWOvvDin1pK8aKteLpeZ5c0A.woff) format('woff');
        }

        @font-face {
            font-family: 'Lato';
            font-style: italic;
            font-weight: 700;
            src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(https://fonts.gstatic.com/s/lato/v11/HkF_qI1x_noxlxhrhMQYELO3LdcAZYWl9Si6vvxL-qU.woff) format('woff');
        }
    }

    /* CLIENT-SPECIFIC STYLES */
    body,
    table,
    td,
    a {
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
    }

    table,
    td {
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
    }

    img {
        -ms-interpolation-mode: bicubic;
    }

    /* RESET STYLES */
    img {
        border: 0;
        height: auto;
        line-height: 100%;
        outline: none;
        text-decoration: none;
    }

    table {
        border-collapse: collapse !important;
    }

    body {
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        width: 100% !important;
    }

    /* iOS BLUE LINKS */
    a[x-apple-data-detectors] {
        color: inherit !important;
        text-decoration: none !important;
        font-size: inherit !important;
        font-family: inherit !important;
        font-weight: inherit !important;
        line-height: inherit !important;
    }

    /* MOBILE STYLES */
    @media screen and (max-width:600px) {
        h1 {
            font-size: 32px !important;
            line-height: 32px !important;
        }
    }

    /* ANDROID CENTER FIX */
    div[style*="margin: 16px 0;"] {
        margin: 0 !important;
    }
</style>
</head>

<body style="background-color: #f4f4f4; margin: 0 !important; padding: 0 !important;">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <!-- LOGO -->
    <tr>
        <td bgcolor="#FFA73B" align="center">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                <tr>
                    <td align="center" valign="top" style="padding: 40px 10px 40px 10px;"> </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td bgcolor="#FFA73B" align="center" style="padding: 0px 10px 0px 10px;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                <tr>
                    <td bgcolor="#ffffff" align="center" valign="top" style="padding: 40px 20px 20px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;">
                        <h1 style="font-size: 40px; font-weight: 400; margin: 2;">Bienvenue sur Monkenewha!</h1> <img src="https://d2w7g2fimm0iao.cloudfront.net/static/media/logo.0c229820.jpeg" width="125" height="120" style="display: block; border: 0px;" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td bgcolor="#f4f4f4" align="center" style="padding: 0px 10px 0px 10px;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                <tr>
                    <td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">
                        <p style="margin: 0;">Merci de l'interêt que vous nous portez ! <br> Afin de commencer à utiliser notre plateforme merci de valider votre adresse email en cliquant sur le bouton ci-dessous. </p>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#ffffff" align="left">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td bgcolor="#ffffff" align="center" style="padding: 20px 30px 60px 30px;">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" style="border-radius: 3px;" bgcolor="#FFA73B"><a href="https://d2w7g2fimm0iao.cloudfront.net/ValidationEmail?token=` + token + `" target="_blank" style="font-size: 20px; font-family: Helvetica, Arial, sans-serif; color: #ffffff; text-decoration: none; color: #ffffff; text-decoration: none; padding: 15px 25px; border-radius: 2px; border: 1px solid #FFA73B; display: inline-block;">Confirmer l'email</a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>                 
                <tr>
                <td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">
                    <p style="margin: 0;">Le lien est valable pendant 24h ! </p>
                </td>
            </tr>
                <tr>
                    <td bgcolor="#ffffff" align="left" style="padding: 0px 30px 40px 30px; border-radius: 0px 0px 4px 4px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">
                        <p style="margin: 0;">Cordialement,<br><br> L'équipe Monkenewha</p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
    <td bgcolor="#f4f4f4" align="center" style="padding: 30px 10px 0px 10px;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
        <tr>
            <td bgcolor="#FFECD1" align="center" style="padding: 30px 30px 30px 30px; border-radius: 4px 4px 4px 4px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;">
                <h2 style="font-size: 20px; font-weight: 400; color: #111111; margin: 0;">Vous souhaitez plus d'informations sur le notre groupe ? <br> Vous souhaitez nous contacter ?</h2>
                <p style="margin: 0;"><a href="https://d2w7g2fimm0iao.cloudfront.net/" target="_blank" style="color: #FFA73B;">Venez découvrir notre site internet</a></p>
            </td>
        </tr>
    </table>
</td>
    </tr>
</table>
</body>

</html>
                `

            }, (error, response) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(response);
                }
                transporter.close();
                rsv("Envoie Fini")
            })
        });

        const item: DynamoDB.PutItemInput = {
            TableName: DB,
            Item: {
                email: { S: email },
                name: { S: name },
                firstName: { S: firstName },
                adresse: { S: adresse },
                password: { S: password },
                isAdmin: { BOOL: false },
                isActif: { BOOL: false },
                jwtokenRecup: { S: "" },
                concert: { S: JSON.stringify([]) }
            },
            ConditionExpression: 'attribute_not_exists(email)',
        };
        await ddb
            .putItem(item)
            .promise()

        return messageReturn(200, "ajout fini")
    }
    catch (e) {
        console.log(e)
        return messageReturn(404, e)
    }

}