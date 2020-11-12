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

router.post('/registration',(req, res) => {
    const requser = req.body

    var flag = true;

    var checkEmail = db.checkEmail(requser.email);
    checkEmail.then(function(result){
        if(result != null){
            console.log("dupaEMAIL");
            flag = false;
        }
    })

    
    var checkName = db.checkName(requser.name);
    checkName.then(function(result){
        if(result != null){
            console.log("dupaNAME");
            flag = false;
        }
    })
    
    if(flag == false){
        res.sendStatus(409);
        return;
    }
   
    var insertUser = db.insertUser(requser.name, requser.email, requser.password)
    insertUser.then(function(result){
        console.log(result.results);
        if(result == null)
            res.sendStatus(409);
        else{
            const user = {name: requser.name, password: requser.password}
            const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
            res.json({accessToken: accessToken})
        }
    })

});

module.exports = router