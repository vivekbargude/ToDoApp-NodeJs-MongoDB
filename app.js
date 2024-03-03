const express = require("express");
const body_parser = require('body-parser');
const UserRoute = require("./routes/user_route");
const TodoRoute = require('./routes/todo_route');

const app = express();

app.use(body_parser.json());

app.use('/',UserRoute);
app.use('/',TodoRoute);

module.exports =  app;