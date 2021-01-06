require("dotenv").config();
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const authentication = require("./routes/authentication");
const events = require("./routes/events");
const { pool } = require("./dbConfig");
const db = require('./controller/db');

app.use(express.json());
app.get('/db', async (req, res) => {
    try {
      const client = await pool.connect();
      const result = await client.query('SELECT * FROM user_account');
      const results = { 'results': (result) ? result.rows : null};
      res.json( results );
      client.release();
    } catch (err) {
      console.error(err);
      res.send("Error " + err);
    }
});

function databaseCleaner() {
  db.deleteOutdatedEvents().then()
}

app.listen(port, () => console.log("Server is running"), () => {
  setInterval(databaseCleaner, 3600000)
});

app.use("/authentication", authentication);
app.use("/events", events);

app.get('/', (req, res) => {
    res.send('hello world')
});
