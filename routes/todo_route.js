
const router = require('express').Router();

const TodoController = require("../controller/todo.controller");

router.post('/storetodo',TodoController.createTodo);

router.post('/getData',TodoController.getData);

router.post('/deleteData',TodoController.deleteData);

module.exports = router;
