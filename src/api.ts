import axios from 'axios';
import sha512 from 'js-sha512';

const apiUrl = "https://a4eslgb0nl.execute-api.eu-west-3.amazonaws.com/prod";
const apiKey = "1HU3xzsQpM7T3JzfYApmS5RyfriD910j9UEqeu6j";


// const test = process.env.REACT_APP_USER_TEST || "";
export default class API {


    static async createConcert(lieu: string, place: number, description: string, date: Date, image: string, heureDeb: string): Promise<boolean> {
        await axios.post(apiUrl + `/concert/add_concert`, {
            lieu: lieu,
            nbrPlace: place,
            description: description,
            date: date,
            img: image,
            nbrPlaceDispo: place,
            heureDeb: heureDeb,
            timestamp: Date.now().toString()
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result.data)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async getConcert(): Promise<any> {
        var concerts: any;
        await axios.get(apiUrl + `/concert/getConcert`, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                concerts = JSON.parse(JSON.parse(result.data.body).response).concert

            }
            catch (e) {
                console.log("ici")

            }
        })

        return concerts;
    }

    static async deleteConcert(id: string): Promise<any> {
        var concerts: any;
        console.log(id)
        await axios.get(apiUrl + `/concert/delete_concert?id=` + id, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                concerts = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async editConcert(id: string, lieu: string, place: number, description: string, date: Date, image: string, heureDeb: string): Promise<any> {
        console.log(id)
        await axios.post(apiUrl + `/concert/edit_concert`, {
            lieu: lieu,
            nbrPlace: place,
            description: description,
            date: date,
            img: image,
            nbrPlaceDispo: place,
            heureDeb: heureDeb,
            id: id
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result.data)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async addMusique(titre: string, musique: string, description: string, image: string): Promise<any> {
        await axios.post(apiUrl + `/musique/add_musique`, {
            titre: titre,
            description: description,
            date: new Date().toJSON().slice(0, 10).replace(/-/g, '/'),
            morceau: musique,
            img: image,
            id: Date.now().toString()
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result.data)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async getMusique(): Promise<any> {
        var nameMusiques: any;
        const result = await axios.get(apiUrl + `/musique/list_musique`, {
            headers: {
                'x-api-key': apiKey
            }
        })
        nameMusiques = JSON.parse(JSON.parse(result.data.body).response).value
        const waitMusique: any = [];
        for (let index = 0; index < nameMusiques.length; index++) {
            const element = nameMusiques[index];
            console.log(element)
            const request = axios.get(apiUrl + `/musique/getMusique?id=` + element, {
                headers: {
                    'x-api-key': apiKey
                }
            })
            waitMusique.push(request)

        }
        var musiques = await Promise.all(waitMusique)
        const finalMusique: any = []
        musiques.forEach((musique) => {
            finalMusique.push(JSON.parse(JSON.parse(musique.data.body).response).musique)
        })
        return finalMusique;
    }

    static async deleteMusique(id: string): Promise<any> {
        var concerts: any;
        console.log(id)
        await axios.get(apiUrl + `/musique/delete_musique?id=` + id, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                concerts = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async editMusique(id: string, titre: string, musique: string, description: string, image: string): Promise<any> {
        await axios.post(apiUrl + `/musique/edit_musique`, {
            id: id,
            titre: titre,
            description: description,
            morceau: musique,
            img: image
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result.data)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async addBlog(titre: string, description: string, date: Date, image: string): Promise<boolean> {
        await axios.post(apiUrl + `/blog/add_blog`, {
            titre: titre,
            description: description,
            date: date,
            img: image,
            timestamp: Date.now().toString()
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result.data)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async getArticles(): Promise<any> {
        var concerts: any;
        await axios.get(apiUrl + `/blog/getBlog`, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                concerts = JSON.parse(JSON.parse(result.data.body).response).blog

            }
            catch (e) {
                console.log("ici")

            }
        })

        return concerts;
    }

    static async editBlog(id: string, titre: string, description: string, image: string): Promise<any> {
        console.log(id)
        await axios.post(apiUrl + `/blog/edit_blog`, {
            titre: titre,
            description: description,
            img: image,
            id: id
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result.data)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async deleteBlog(id: string): Promise<any> {
        var concerts: any;
        console.log(id)
        await axios.get(apiUrl + `/blog/delete_blog?id=` + id, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                concerts = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async createAccount(email: string, password: string, name: string, firstName: string, adresse: string): Promise<any> {
        var user: any;

        await axios.post(apiUrl + `/user/add_user`, {
            email: email,
            password: sha512.sha512(password),
            name: name,
            firstName: firstName,
            adresse: adresse
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                user = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async validateAccount(token: string): Promise<any> {
        var user: any;

        await axios.post(apiUrl + `/user/validation_email`, {
            token: token
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                user = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async lostPassword(email: string): Promise<any> {
        var user: any;

        await axios.post(apiUrl + `/user/lost_password`, {
            email: email
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                user = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async changePassword(token: string): Promise<any> {
        var user: any;

        await axios.post(apiUrl + `/user/reinitialise_password`, {
            token: token
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                user = JSON.parse(result.data.response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(user);
        });
    }

    static async updatePassword(email: string, password: string, actualPassword: string = ""): Promise<any> {
        var user: any;

        if(actualPassword === ""){
            await axios.post(apiUrl + `/user/update_password`, {
                email: email,
                password: sha512.sha512(password)
            }, {
                headers: {
                    'x-api-key': apiKey
                }
            }).then(result => {
                try {
                    console.log(result)
                    user = JSON.parse(JSON.parse(result.data.body).response)
    
                }
                catch (e) {
                    console.log("ici")
    
                }
            })
        }
        else{
            await axios.post(apiUrl + `/user/update_password`, {
                email: email,
                password: sha512.sha512(password),
                actualPassword: sha512.sha512(actualPassword)
            }, {
                headers: {
                    'x-api-key': apiKey
                }
            }).then(result => {
                try {
                    console.log(result)
                    user = JSON.parse(JSON.parse(result.data.body).response)
    
                }
                catch (e) {
                    console.log("ici")
    
                }
            })
        }

       

        return new Promise(resolve => {
            resolve(true);
        });
    }
    static async updateUser(email: string, adresse: string,name: string,firstName: string): Promise<any> {
        var user: any;

        await axios.post(apiUrl + `/user/update_user`, {
            email: email,
            adresse: adresse,
            name: name,
            firstName: firstName
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                user = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async contact(email: string, description: string,name: string,firstName: string): Promise<any> {
        var user: any;

        await axios.post(apiUrl + `/contact`, {
            email: email,
            description: description,
            name: name,
            firstName: firstName
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                user = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

    static async reserveConcert(email: string, idConcert: string,placePrise: number,concerts: string): Promise<any> {
        var user: any;

        await axios.post(apiUrl + `/reserve_concert`, {
            email: email,
            idConcert: idConcert,
            placePrise: placePrise,
            concerts: concerts
        }, {
            headers: {
                'x-api-key': apiKey
            }
        }).then(result => {
            try {
                console.log(result)
                user = JSON.parse(JSON.parse(result.data.body).response)

            }
            catch (e) {
                console.log("ici")

            }
        })

        return new Promise(resolve => {
            resolve(true);
        });
    }

}

