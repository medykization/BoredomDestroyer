const db = require('../controller/db')

function checkIfEmailExist(req, res, next) {
    const requser = req.body

    var checkEmail = db.checkEmail(requser.email);
    checkEmail.then(function(result){
        if(result != null){
            res.locals.emailError = true
        }
        next();
    })
};

function checkIfNameExist(req, res, next) {
    const requser = req.body

    var checkName = db.checkName(requser.name); 
    checkName.then(function(result){
        if(result != null){
            res.locals.nameError = true
        }
        next();
    })
};


exports.checkIfEmailExist = checkIfEmailExist
exports.checkIfNameExist = checkIfNameExist