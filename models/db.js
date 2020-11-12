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
            return null;
        }

    }catch (err) {
        return null;
    }
};

async function checkValueInColumn(collumn_name, value) {
    try {
        const client = await pool.connect();
        const selectQuery = 'SELECT *  FROM $1 WHERE $1 = $2 ';
        const result = await client.query(selectQuery, [collumn_name, value]);
        const results = { 'results': (result) ? result.rows : null};

        if(result.rows[0] != null){
            return results;
        }
        else{
            return null;
        }

    }catch (err) {
        return null;
    }finally{
        client.release();
    }
};

async function insertUser(username, email, password) {
    try {
        const client = await pool.connect();
        const selectQuery = 'INSERT INTO users(user_name ,user_email, user_pass) VALUES ($1, $2, $3) ';
        const result = await client.query(selectQuery, [username, email, password]);
        const results = { 'results': (result) ? result.rows : null};

        if(result.rows[0] != null){
            return results;
        }
        else{
            return null;
        }
    }catch (err) {
        return null;
    }finally{
        client.release();
    }
};

exports.checkUser = checkUser
exports.checkValueInColumn = checkValueInColumn
exports.insertUser = insertUser