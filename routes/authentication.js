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

    var checkEmail = db.checkUser('user_email', requser.email);
    checkEmail.then(function(result){
        if(result.results[0] == null)
            res.sendStatus(409);
    })

    var checkName = db.checkUser('user_name', requser.name);
    checkName.then(function(result){
        if(result.results[0] == null)
            res.sendStatus(409);
    })

    var insertUser = db.insertUser(requser.name, requser.email, requser.password)
    insertUser.then(function(result){
        if(result.results[0] == null)
            res.sendStatus(409);
        else{
            const user = {name: requser.name, password: requser.password}
            const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
            res.json({accessToken: accessToken})
        }
    })
});

module.exports = router