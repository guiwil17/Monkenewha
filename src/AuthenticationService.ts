import axios from 'axios';

const apiUrl = "https://a4eslgb0nl.execute-api.eu-west-3.amazonaws.com/prod";
const apiKey = "1HU3xzsQpM7T3JzfYApmS5RyfriD910j9UEqeu6j";

// const test = process.env.REACT_APP_USER_TEST || "";
export default class AuthenticationService {

    static user: any = {} as any;
    static isAuthenticated: boolean = false;

    static async login(pseudo: string, password: string): Promise<boolean> {
        console.log("ici")
        await axios.post(apiUrl + `/login`, {
            email: pseudo,
            password: password
        } ,{
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result.data)
                this.user = JSON.parse(result.data.response).token
                this.isAuthenticated = true
            }
            catch (e) {
                console.log("ici")

                this.isAuthenticated = false
            }
        })

        return new Promise(resolve => {
            resolve(this.isAuthenticated);
        });
    }

    // static async testLogin(): Promise<boolean> {
    //     try {
    //         this.user = JSON.parse(test);
    //         this.isAuthenticated = true;
    //     }
    //     catch (e) {
    //         this.isAuthenticated = false;
    //     }
    //     return new Promise(resolve => {
    //         resolve(this.isAuthenticated);
    //     });
    // }
}

