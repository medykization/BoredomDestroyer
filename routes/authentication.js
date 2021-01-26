const express = require('express');
const jwt = require('jsonwebtoken');
let router = express.Router();
const db = require('../controller/db');
const exist = require('../middleware/credentials');
const auth = require('../middleware/authorization');

router.post('/refresh',(req, res) => {
    const refreshToken = req.body.token
    if(refreshToken == null) return res.sendStatus(401)
    //check if refreshtoken exist in database
    jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (err, user) => {
        if(err) return res.sendStatus(403)
        const name = user.name
        const accessToken = jwt.sign({name: name}, process.env.ACCES_TOKEN_SECRET, {expiresIn: '10m'});
        return res.json({accessToken: accessToken})
    })
});

router.post('/login',(req, res) => {
    const body = req.body
    var check = db.checkUser(body.name,body.password);

    check.then(function(result){
        if(result != null) {
            const user = {name: body.name}
            const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET, {expiresIn: '10m'});
            const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
            res.json({accessToken: accessToken, refreshToken: refreshToken})
        }
        else {
            res.sendStatus(400)
        }
    })
});

router.post('/registration', exist.checkIfEmailExist, exist.checkIfNameExist, (req, res) => {
    if(req.emailError || req.nameError)
        return res.sendStatus(409);

    const body = req.body

    var insertUser = db.insertUser(body.name, body.email, body.password)
    insertUser.then(function(result){
        console.log(result.results);
        if(result == null)
            return res.sendStatus(409);
        else{
            const user = {name: body.name}
            const accessToken = jwt.sign(user, process.env.ACCES_TOKEN_SECRET, {expiresIn: '10m'});
            const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
            res.json({accessToken: accessToken, refreshToken: refreshToken})
        }
    })

});

router.post('/email', exist.checkIfEmailExist, (req, res) => {
    if(res.locals.emailError)
        return res.sendStatus(409);
    return res.sendStatus(200);
});

router.post('/username', exist.checkIfNameExist, (req, res) => {
    if(res.locals.nameError) {
        return res.sendStatus(409);
    }
    return res.sendStatus(200);
});

module.exports = router