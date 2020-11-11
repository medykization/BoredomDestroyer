require("dotenv").config();
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const authentication = require("./routes/authentication"); 
app.use(express.json());


app.listen(port, () => console.log("Server is running"));

app.use("/authentication", authentication);

app.get('/', (req, res) => {
    res.send('hello world')
});