const express = require('express');
const User  = require("../models/user");
const Event  = require("../models/event");
const auth = require('../middleware/authorization');
const db = require('../controller/db');
let router = express.Router();

router.get('/categories', auth.authenticateToken, (req, res) => {
    var check = db.getCategories();
    check.then(function(result){
        if(result != null) {
            res.json(result)
        }
        else {
            res.sendStatus(400)
        }
    })
});

router.get('/local', auth.authenticateToken, (req, res) => {
    const body = req.body
    var check = db.getLocalEvents(body.city);
    check.then(function(result){
        if(result != null) {
            res.json(result)
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
    jwt.verify(token, process.env.ACCES_TOKEN_SECRET, (err, user) => {user_name = user})

    var userId = db.getUserIdFromName(user_name)
    userId.then(function(result){
        if(result != null) {

            const body = req.body

            var category_id
            var categoryID = db.getEventCategoryId(body.category_name);
            categoryID.then(function(result){
                if(result != null) {
                    category_id = result
                    
                    var event = new Event(user_id,body.event_name,category_id,body.description,
                        body.location,body.begin_time,body.end_time,0)
                    var check = db.getLocalEvents(event);
                    check.then(function(result){
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

        }
        else {
            res.sendStatus(400)
        }
    })
});