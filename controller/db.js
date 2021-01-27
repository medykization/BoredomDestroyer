const { pool } = require("../dbConfig");
const  User  = require("../models/user");
const  Event  = require("../models/event");

async function getCategories() {
    const client = await pool.connect();
    try {
        const selectQuery = 'SELECT category_name FROM event_category';
        const result = await client.query(selectQuery);
        const results = { 'results': (result) ? result.rows : null};
        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }

    }catch (err) {
        client.release();
        return null;
    }
};

async function getEventCategoryId(category_name) {
    const client = await pool.connect();
    try {  
        const selectQuery = 'SELECT id FROM event_category WHERE category_name = $1';
        const result = await client.query(selectQuery, [category_name]);
        const results = { 'results': (result) ? result.rows : null};
        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }

    }catch (err) {
        client.release();
        return null;
    }
};

async function getLocalEvents(city, user_id) {
    const client = await pool.connect();
    try {
        const selectQuery = 'select e.id , e.user_id, e.event_name, e.category_id, e.description, e.location_city, e.location_address, e.begin_time, e.end_time, ec.category_name,\
        (select COALESCE(sum(vote),0) from event_votes where event_id = e.id) as rating,\
        COALESCE((select vote from event_votes where user_id = $1 and event_id = e.id),0) as vote\
        from event e join event_category ec on e.category_id = ec.id WHERE e.location_city = $2 GROUP BY e.id, ec.category_name';
        const result = await client.query(selectQuery, [user_id, city]);
        const results = { 'results': (result) ? result.rows : null};
        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }

    }catch (err) {
        client.release();
        return null;
    }
};

async function insertEvent(event) {
    const client = await pool.connect();
    try {
        const selectQuery = 'INSERT INTO event(user_id ,event_name, category_id, description, location_city, location_address, begin_time, end_time, rating)\
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *';
        const result = await client.query(selectQuery, [event.user_id, event.event_name, event.category_id, event.description,
                                                         event.location_city,event.location_address, event.begin_time, event.end_time, event.rating]);
        const results = { 'results': (result) ? result.rows : null};

        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }
    }catch (err) {
        client.release();
        return null;
    }
};

async function checkUser(username, password) {
    const client = await pool.connect();
    try {
        const selectQuery = 'SELECT *  FROM user_account WHERE user_name = $1 AND user_pass = $2';
        const result = await client.query(selectQuery, [username, password]);
        const results = { 'results': (result) ? result.rows : null};

        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }

    }catch (err) {
        client.release();
        return null;
    }
};

async function checkEmail(value) {
    const client = await pool.connect();
    try {
        const result = await client.query("SELECT user_email FROM user_account WHERE user_email = $1", [value]);
        const results = { 'results': (result) ? result.rows : null};

        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }

    }catch (err) {
        client.release();
        return null;
    }
};

async function checkName(value) {
    const client = await pool.connect();
    try {
        const result = await client.query("SELECT user_name FROM user_account WHERE user_name = $1", [value]);
        const results = { 'results': (result) ? result.rows : null};
        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }
    }catch (err) {
        client.release();
        return null;
    }
};

async function getUserIdFromName(name) {
    const client = await pool.connect();
    try {
        const result = await client.query("SELECT id FROM user_account WHERE user_name = $1", [name]);
        const results = { 'results': (result) ? result.rows : null};

        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }

    }catch (err) {
        client.release();
        return null;
    }
};

async function insertUser(username, email, password) {
    const client = await pool.connect();
    try {
        const selectQuery = 'INSERT INTO user_account(user_name ,user_email, user_pass) VALUES ($1, $2, $3) RETURNING *';
        const result = await client.query(selectQuery, [username, email, password]);
        const results = { 'results': (result) ? result.rows : null};

        if(result.rows[0] != null){
            client.release();
            return results;
        }
        else{
            client.release();
            return null;
        }
    }catch (err) {
        client.release();
        return null;
    }
};

async function deleteOutdatedEvents() {
    const client = await pool.connect();
    try {
        const deleteQuery = "DELETE FROM event WHERE end_time < NOW() - INTERVAL '1' MINUTE";
        await client.query(deleteQuery);
    }catch (err) {
        client.release();
        return null;
    }
};

async function insertVote(event_id, user_id, vote_value) {
    const client = await pool.connect();
    try {
        const selectQuery = 'INSERT INTO event_votes (user_id, event_id, vote) VALUES ($1, $2, $3) ON CONFLICT (user_id, event_id) DO UPDATE SET vote = $3';
        await client.query(selectQuery, [user_id, event_id, vote_value]);
        client.release();
        return "values updated";
    }catch (err) {
        client.release();
        return null;
    }
};

async function deleteUserVote(event_id, user_id) {
    const client = await pool.connect();
    try {
        const selectQuery = 'DELETE FROM event_votes WHERE user_id = $1 and event_id = $2';
        await client.query(selectQuery, [user_id, event_id]);
        client.release();
        return "values deleted";
    }catch (err) {
        client.release();
        return null;
    }
};

exports.deleteOutdatedEvents = deleteOutdatedEvents
exports.getEventCategoryId = getEventCategoryId
exports.getUserIdFromName = getUserIdFromName
exports.deleteUserVote = deleteUserVote
exports.getLocalEvents = getLocalEvents
exports.getCategories = getCategories
exports.insertEvent = insertEvent
exports.checkEmail = checkEmail
exports.insertUser = insertUser
exports.insertVote = insertVote
exports.checkUser = checkUser
exports.checkName = checkName
