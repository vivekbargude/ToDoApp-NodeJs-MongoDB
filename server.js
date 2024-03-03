const app = require("./app");
const db = require("./config/db");
const UserModel = require("./models/user");
const colors = require('colors');
const TodoModel = require('./models/todo_model');
const port = 3000;

app.get('/', (req,res)=>{
    res.send('Hello users')
});


app.listen(3000, () => {

    console.log('SERVER RUNNING AT http://localhost:3000'.red.underline.bold);
});