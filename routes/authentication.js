const express = require('express');
const jwt = require('jsonwebtoken');
let router = express.Router();
const db = require('../controller/db');
const exist = require('../middleware/user_exist');

router.post('/login',(req, res) => {
    const body = req.body
    var check = db.checkUser(body.name,body.password);

    check.then(function(result){
        if(result != null) {
            const user = {name: body.name, password: body.password}
            const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
            res.json({accessToken: accessToken})
        }
        else {
            res.sendStatus(400)
        }
    })
});


router.post('/registration', exist.checkIfEmailExist, exist.checkIfNameExist, (req, res) => {
    const body = req.body

    var insertUser = db.insertUser(body.name, body.email, body.password)
    insertUser.then(function(result){
        console.log(result.results);
        if(result == null)
            return res.sendStatus(409);
        else{
            const user = {name: body.name, password: body.password}
            const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET);
            res.json({accessToken: accessToken})
        }
    })

});

module.exports = router