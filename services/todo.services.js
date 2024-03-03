const TodoModel  = require("../models/todo_model");

class TodoServices{

    static async createTodo(userId,title,desc)
    {

        const newTodo = new TodoModel({userId,title,desc});
        return await newTodo.save();

    }

    static async getAllData(userId){

        const AllData = await TodoModel.find({userId});
        return AllData;

    }

    static async DeleteAData(id){

        const deletedItem = await TodoModel.findOneAndDelete({_id:id});

        return deletedItem;

    }
}

module.exports = TodoServices;