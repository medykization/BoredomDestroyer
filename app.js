require("dotenv").config();
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const authentication = require("./routes/authentication"); 
const { pool } = require("./dbConfig");

//  middleware
app.use(express.json());

app.get('/db', async (req, res) => {
    try {
      const client = await pool.connect();
      const result = await client.query('SELECT * FROM users');
      const results = { 'results': (result) ? result.rows : null};
      res.json( results );
      client.release();
    } catch (err) {
      console.error(err);
      res.send("Error " + err);
    }
  })

app.listen(port, () => console.log("Server is running"));

app.use("/authentication", authentication);

app.get('/', (req, res) => {
    res.send('hello world')
});
