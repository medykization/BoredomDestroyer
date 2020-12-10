const { pool } = require("../dbConfig");
const  User  = require("../models/user");
const  Event  = require("../models/event");

async function getCategories() {
    try {
        const client = await pool.connect();
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
    try {
        const client = await pool.connect();
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

async function getLocalEvents(city) {
    try {
        const client = await pool.connect();
        const selectQuery = 'SELECT * FROM event WHERE event_location -> \'city\' = $1';
        const result = await client.query(selectQuery, city);
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
    try {
        const client = await pool.connect();
        const selectQuery = 'INSERT INTO event(user_id ,event_name, category_id, description, location, begin_time, end_time, rating)\
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *';
        const result = await client.query(selectQuery, [event.id, event.event_name, event.category_id, event.description, event.location, event.begin_time, event.end_time, event.rating]);
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
    try {
        const client = await pool.connect();
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
    try {
        const client = await pool.connect();
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
        return null;
    }
};

async function checkName(value) {
    try {
        const client = await pool.connect();
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
        return null;
    }
};

async function getUserIdFromName(name) {
    try {
        const client = await pool.connect();
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
        return null;
    }
};

async function insertUser(username, email, password) {
    try {
        const client = await pool.connect();
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
getEventCategoryId
exports.getEventCategoryId = getEventCategoryId
exports.getUserIdFromName = getUserIdFromName
exports.getLocalEvents = getLocalEvents
exports.insertEvent = insertEvent
exports.checkUser = checkUser
exports.checkEmail = checkEmail
exports.insertUser = insertUser
exports.checkName = checkName
exports.getCategories = getCategories