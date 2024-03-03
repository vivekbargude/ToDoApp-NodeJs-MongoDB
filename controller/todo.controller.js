const TodoServices = require("../services/todo.services");

exports.createTodo = async (req, res, next) => {

    try {

        const { userId, title, desc } = req.body;

        let todo = await TodoServices.createTodo(userId, title, desc);

        res.status(200).json({
            success: true,
            data: todo
        })

    } catch (error) {
        next(error);
    }
}

exports.getData = async (req, res, next) => {

    try {

        const { userId } = req.body;

        let todoData = await TodoServices.getAllData(userId);

        res.status(200).json({
            success: true,
            data: todoData
        });

    } catch (error) {
        next(error);
    }
}

exports.deleteData = async (req, res, next) => {

    try {
        
        const { id } = req.body;

        const deleted = await TodoServices.DeleteAData(id);

        res.status(200).json({
            success:true,
            data : deleted
        });

    } catch (error) {
        next(error);
    }
}