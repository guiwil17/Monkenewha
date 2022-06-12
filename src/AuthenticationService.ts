import axios from 'axios';
import sha512 from 'js-sha512';

const apiUrl = "https://a4eslgb0nl.execute-api.eu-west-3.amazonaws.com/prod";
const apiKey = "1HU3xzsQpM7T3JzfYApmS5RyfriD910j9UEqeu6j";

// const test = process.env.REACT_APP_USER_TEST || "";
export default class AuthenticationService {

    static user: any = {} as any;
    static isAdmin: boolean = false; 
    static nom: string = ""; 
    static firstName: string = ""; 
    static adresse: string = ""; 
    static email: string = ""; 
    static isAuthenticated: boolean = false;
    static concert: any = {} as any;

    static async login(pseudo: string, password: string): Promise<boolean> {
        console.log("ici")
        await axios.post(apiUrl + `/login`, {
            email: pseudo,
            password: sha512.sha512(password)
        } ,{
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result.data)
                const user = JSON.parse(result.data.response)
                this.nom = user.name
                this.firstName = user.firstName
                this.email = user.email
                this.adresse = user.adresse
                this.isAdmin = JSON.parse(result.data.response).isAdmin
                console.log(JSON.parse(result.data.response).concert)
                this.concert = JSON.parse(JSON.parse(result.data.response).concert)
                this.isAuthenticated = true
            }
            catch (e) {
                console.log(e)
                console.log("ici")

                this.isAuthenticated = false
            }
        })

        return new Promise(resolve => {
            resolve(this.isAuthenticated);
        });
    }

    static async logout(): Promise<boolean> {
        console.log("ici")
            this.nom = ""
            this.firstName = ""
            this.email = ""
            this.adresse = ""
            this.isAdmin = false
            this.concert = ""
            this.isAuthenticated = false

        return new Promise(resolve => {
            resolve(this.isAuthenticated);
        });
    }
    
    static async updateUser(name: string, firstName: string, adresse: string): Promise<boolean> {
        this.nom = name
        this.firstName = firstName
        this.adresse = adresse          
    return new Promise(resolve => {
        resolve(true);
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

