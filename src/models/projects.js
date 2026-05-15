import db from './db.js'
/*
This code does the following:

Imports the database connection from the db.js file.
Defines an asynchronous function getAllOrganizations that queries the database for all organizations.
Returns the rows of the result if successful.
Exports the getAllOrganizations function so it can be used in other parts of the application.
*/

const getAllProjecs = async() => {
    const query = `
        SELECT project_id, organization_id, title, description, location, project_date
	FROM public.service_projects; 
    `;

    const result = await db.query(query);

    return result.rows;
}

export {getAllProjecs} 

