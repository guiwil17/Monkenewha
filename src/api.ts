import axios from 'axios';

const apiUrl = "https://a4eslgb0nl.execute-api.eu-west-3.amazonaws.com/prod";
const apiKey = "1HU3xzsQpM7T3JzfYApmS5RyfriD910j9UEqeu6j";

// const test = process.env.REACT_APP_USER_TEST || "";
export default class API {

 
    static async createConcert(lieu: string, place: number, description: string, date: Date, image: string): Promise<boolean> {
        console.log("ici")
        await axios.post(apiUrl + `/concert/add_concert`, {
            lieu: lieu,
            nbrPlace: place,
            description : description,
            date: date, 
            img: image,
            nbrPlaceDispo: place,
            timestamp : Date.now().toString()
        } ,{
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
  
}

