const db = require('../controller/db')

function checkIfEmailExist(req, res, next) {
    const requser = req.body

    var checkEmail = db.checkEmail(requser.email);
    checkEmail.then(function(result){
        if(result != null){
            return res.sendStatus(409);
        }
        next();
    })
};

function checkIfNameExist(req, res, next) {
    const requser = req.body

    var checkName = db.checkName(requser.name); 
    checkName.then(function(result){
        if(result != null){
            return res.sendStatus(409);
        }
        next();
    })
};


exports.checkIfEmailExist = checkIfEmailExist
exports.checkIfNameExist = checkIfNameExist