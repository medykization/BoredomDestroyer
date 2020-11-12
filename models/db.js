const { pool } = require("../dbConfig");

async function checkUser(username, password) {
    try {
        const client = await pool.connect();
        const selectQuery = 'SELECT *  FROM users WHERE user_name = $1 AND user_pass = $2';
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
        const result = await client.query("SELECT user_email FROM users WHERE user_email = $1", [value]);
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
        const result = await client.query("SELECT user_name FROM users WHERE user_name = $1", [value]);
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
        const selectQuery = 'INSERT INTO users(user_name ,user_email, user_pass) VALUES ($1, $2, $3) RETURNING *';
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

exports.checkUser = checkUser
exports.checkEmail = checkEmail
exports.insertUser = insertUser
exports.checkName = checkName