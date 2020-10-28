require("dotenv").config();
const express = require('express');
const jwt = require('jsonwebtoken');
const app = express();
const port = process.env.PORT || 3000
app.use(express.json())

const userinfos = [
    {
        name: 'leon',
        info: "info leona"
    },
    {
        name: 'michal',
        info: "info michala"
    }
]

app.listen(port, () => console.log("Server is running"))

app.post('/login', (req, res) => {
    const username = req.body.name
    const user = {name: username}
    const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
    res.json({accessToken: accessToken})
})

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
}

app.get('/userinfo', authenticateToken , (req, res) => {
    res.json(userinfos.filter(userinfo => userinfo.username === req.userinfo.username))
})

app.get('/', (req, res) => {
    res.send('hello world')
})