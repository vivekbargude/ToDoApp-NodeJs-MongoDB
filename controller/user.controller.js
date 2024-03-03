const UserService = require("../services/user.services");  //handling data from frontend // controller 


exports.register = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        const successRes = await UserService.registerUser(email, password);

        res.json({
            success: true,
            msg: "User Registered SuccessFully",
        }
        )

    } catch (err) {
        throw err;
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        const user = await UserService.ChecKUser(email);

        if (!user) {

            throw new Error('User Doesnt Exists');

        }

        else {
            const isMatch = await user.comparePass(password);

            if(!isMatch){

                throw new Error('INvalid Password');

            }

            else{
                
                let  tokendata = {
                    _id : user._id,
                    email : user.email
                }

                const token = await UserService.generateToken(tokendata,"secretKey",'1h');

                res.status(200).json({
                    success : true,
                    token : token,
                    msg : "User Logged in Successfully"
                })
            }

        }


    } catch (err) {
        throw err;
    }
}