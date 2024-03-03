const UserModel = require("../models/user");  // to provide necessary services to controller 
const jwt = require('jsonwebtoken')


class UserService {

    static async registerUser(email,password){
        try{

            const CreateUser = new UserModel({email,password}); //error 1 : throw new ObjectParameterError(obj, 'obj', 'Document');  because of (email,password ) => ({email,passwrd})
            return await CreateUser.save();

        }catch(err){
            throw err;
        }
    }

    static async ChecKUser(email){
        try{

            return await UserModel.findOne({email});

        }catch(err){
            throw err;
        }
    }


    static async generateToken(tokendata,secretKey,jwt_expire){
        return jwt.sign(tokendata,secretKey,{
            expiresIn : jwt_expire
        })
    }
}



module.exports = UserService;