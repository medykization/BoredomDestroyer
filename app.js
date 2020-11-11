require("dotenv").config();
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const authentication = require("./routes/authentication"); 
app.use(express.json());


app.listen(port, () => console.log("Server is running"));

app.use("/authentication", authentication);

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization']
    // if we have authHeader return authHeader.split(' ')[1]
    const token = authHeader && authHeader.split(' ')[1]
    if(token == null) 
        return res.sendStatus(401)

    jwt.verify(token, process.env.ACCES_TOKEN_SECRET, (err, user) => {
        if(err)
            return res.sendStatus(403)
        req.user = user
        next()
    })
};

app.get('/', (req, res) => {
    res.send('hello world')
});