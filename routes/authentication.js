const express = require('express');
const jwt = require('jsonwebtoken');
let router = express.Router();
const db = require('../models/db')
require('../middleware/user_exist')

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

router.post('/registration', checkIfUserExist, (req, res) => {
    const requser = req.body

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