const mongoose = require('mongoose');

const db = require("../config/db");

const bcrypt = require('bcrypt');

const UserModel = require('../models/user');


const { Schema } = mongoose;

const TodoSchema = new Schema({

    userId:{
        type : Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    title:{
        type : String,
        required : true
    },
    desc:{
        type : String,
        required : true,
    },
});


const TodoModel = db.model('todo', TodoSchema);

module.exports = TodoModel;