import { eq } from "drizzle-orm"
import db from "./drizzle/db";
import { state_table } from "./drizzle/schema";


const getStateWithCities = async () => {
    return await db.query.state_table.findMany({    
        with: {
            cities: true
        }
    });
}

const getCitiesWithRestaurants = async () => {
    return await db.query.city_table.findMany({
        with: {
            restaurants: true
        }
    });
}

async function main() {
    // console.log( await getStateWithCities()); 
    console.log( await getCitiesWithRestaurants());  
}

main();
main().catch((e)=>{
    console.log(e);
});
