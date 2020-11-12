const express = require('express');
const jwt = require('jsonwebtoken');
let router = express.Router();
const db = require('../models/db')

const users = [];

router.post('/login' ,(req, res) => {
    const requser = req.body
    //check for user in database
    
    var check = db.checkUser(requser.name,requser.password);

    check.then(function(result){

        console.log(result != null);
        if(result != null) {
            const user = {name: requser.name, password: requser.password}
            const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
            res.json({accessToken: accessToken})
        }
        else {
            res.sendStatus(400)
        }
    })
});

router.post('/registration' ,(req, res) => {
    const requser = req.body
    if( users.find(user => user.name === requser.name
         && user.password === requser.password)) {
            res.sendStatus(400)
    }
    else {
        const user = {name: requser.name, password: requser.password}
        //add user to database
        users.push(user)
        const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
        res.json({accessToken: accessToken})
    }
});

module.exports = router