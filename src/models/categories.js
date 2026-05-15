import db from './db.js'
/*
This code does the following:

Imports the database connection from the db.js file.
Defines an asynchronous function getAllCategoriesthat queries the database for all service projects.
Returns the rows of the result if successful.
Exports the getAllCategories function so it can be used in other parts of the application.
*/

const getAllCategories = async() => {
    const query = `
        SELECT category_id, name
	FROM public.category; 
    `;

    const result = await db.query(query);

    return result.rows;
}

export {getAllCategories} 

