const db = require('../models/db')

function checkIfUserExist(req, res, next) {
    const requser = req.body

    var flag = true;

    var checkEmail = db.checkEmail(requser.email);
    var checkName = db.checkName(requser.name);
    checkEmail.then(function(result){
        if(result != null){
            console.log("dupaEMAIL");
            flag = false;
        }
    }).checkName.then(function(result){
        if(result != null){
            console.log("dupaNAME");
            flag = false;
        }
    })

    if(flag == false){
        return res.sendStatus(409);
    }

    next();
};

exports.checkIfUserExist = checkIfUserExist