const express = require('express');
const jwt = require('jsonwebtoken');
let router = express.Router();


const users = [
    {
        name: 'leon',
        password: '1234'
    },
    {
        name: 'michal',
        password: '1234'
    },
    {
        name: 'kuba',
        password: '1234'
    }
];

const userinfos = [
    {
        name: 'leon',
        info: "info leona"
    },
    {
        name: 'michal',
        info: "info michala"
    }
];

router.post('/login' ,(req, res) => {
    const requser = req.body
    if( users.find(user => user.name === requser.name
         && user.password === requser.password)) {
        const user = {name: requser.name, password: requser.password}
        const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
        res.json({accessToken: accessToken})
    }
    else {
        res.sendStatus(400)
    }
});

router.post('/registration' ,(req, res) => {
    const requser = req.body
    if( users.find(user => user.name === requser.name
         && user.password === requser.password)) {
            res.sendStatus(400)
    }
    else {
        const user = {name: requser.name, password: requser.password}
        users.push(user)
        const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
        res.json({accessToken: accessToken})
    }
});

module.exports = router