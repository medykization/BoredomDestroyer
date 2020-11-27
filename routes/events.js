const express = require('express');
const { User } = require("../models/user");
const { Event } = require("../models/event");
const auth = require('../middleware/authorization');
let router = express.Router();

router.get('/all',auth.authenticateToken, (req, res) => {

});

router.post('/all',auth.authenticateToken, (req, res) => {

});