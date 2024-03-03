const mongoose = require('mongoose');
const colors = require('colors');

const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/ToDoApp').on('open',()=>{
    console.log("MongoDB Connected".blue.bold);
}).on('error',()=>{
    console.log("MongoDB Connection Failed".blue.bold);
});


module.exports = connection;
