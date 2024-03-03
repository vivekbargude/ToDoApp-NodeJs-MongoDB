const mongoose = require('mongoose');

const db = require("../config/db");

const bcrypt = require('bcrypt');



const { Schema } = mongoose;

const UserSchema = new Schema({
    email:{
        type : String,
        lowercase : true,
        required : true,
        unique: true
    },
    password:{
        type : String,
        required : true,
    }
});

UserSchema.pre('save',async function(){
    try{
        var user = this;
        const salt = await(bcrypt.genSalt(10));

        const hashpass = await bcrypt.hash(user.password,salt);

        user.password = hashpass;

    }catch(error){

    }
});

UserSchema.methods.comparePass = async function(userpassword){

    try{

        const isMatch = await bcrypt.compare(userpassword,this.password);
        return isMatch;
        
    }catch(err){
        throw err;
    }
    
}

const UserModel = db.model('user', UserSchema);

module.exports = UserModel;
