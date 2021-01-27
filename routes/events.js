const express = require('express');
const User  = require("../models/user");
const Event  = require("../models/event");
const auth = require('../middleware/authorization');
const db = require('../controller/db');
const jwt = require('jsonwebtoken');

let router = express.Router();
//change to get
router.post('/categories', auth.authenticateToken, (req, res) => {
    db.getCategories().then(function(result){
        if(result != null) {
            res.json(result)
        }
        else {
            res.sendStatus(400)
        }
    })
});
//change to get
router.post('/local', auth.authenticateToken, (req, res) => {
    const body = req.body
    db.getUserIdFromName(body.username).then(function(result){
        if(result != null) {
            var user_id = result.results[0].id;
            db.getLocalEvents(body.city, user_id).then(function(result){
                if(result != null) {
                    res.json(result)
                }
                else {
                    res.sendStatus(400)
                }
            })
        }
        else {
            res.sendStatus(400)
        }
    })
});

router.post('/add', auth.authenticateToken, (req, res) => {
    var user_name
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    jwt.verify(token, process.env.ACCES_TOKEN_SECRET, (err, user) => {user_name = user.name})

    var userId = db.getUserIdFromName(user_name)
    userId.then(function(result){
        if(result != null) {
            console.log(result.results[0].id);
            var user_id = result.results[0].id;
            const body = req.body

            var event = new Event(user_id,body.event_name,body.category_id,body.description,
                body.location_city,body.location_address,body.begin_time,body.end_time,0)
            var check = db.insertEvent(event);
            check.then(function(result){
                if(result != null) {
                    res.sendStatus(200)
                }
                else {
                    res.sendStatus(400)
                }
            })

        }
        else {
            res.sendStatus(400)
        }
    })
});

router.post('/vote', auth.authenticateToken, (req, res) => {
    const body = req.body
    const value = body.vote
    const event_id = body.event_id
    db.getUserIdFromName(body.username).then(function(result){
        if(result != null) {
            var user_id = result.results[0].id;
            var check = db.insertVote(event_id, user_id, value);
            check.then(function(result){
                if(result != null) {
                    res.sendStatus(200)
                }
                else {
                    res.sendStatus(400)
                }
            })

        }
        else {
            res.sendStatus(400)
        }
    })
});

router.post('/delete/vote', auth.authenticateToken, (req, res) => {
    body = req.body
    db.getUserIdFromName(body.username).then(function(result){
        if(result != null) {
            var user_id = result.results[0].id;
            db.deleteUserVote( body.event_id,user_id).then(function(result) {
                if(result == null) {
                    return res.sendStatus(400)
                }
                return res.sendStatus(200)
            })
        }
        else {
            res.sendStatus(400)
        }
    })
});

module.exports = router