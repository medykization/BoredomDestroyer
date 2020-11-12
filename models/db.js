const { pool } = require("../dbConfig");

async function checkUser(username, password) {
    try {
        const client = await pool.connect();
        const selectQuery = 'SELECT *  FROM users WHERE user_name = $1 AND user_pass = $2';
        const result = await client.query(selectQuery, [username, password]);
        const results = { 'results': (result) ? result.rows : null};

        if(result.rows[0] != null){
            //console.log(result.rows[0]);
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

exports.checkUser = checkUser