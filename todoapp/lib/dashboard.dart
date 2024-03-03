import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/config.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {

  final token;
  const DashBoard({@required this.token,Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  late String userId;
  TextEditingController _todoTitle = TextEditingController();
  TextEditingController _todoDesc = TextEditingController();
   List? items;

  @override
  void initState() {
    super.initState();

    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    
    userId = jwtDecodedToken['_id'];
    getAllData(userId);

  }


   void addTodo() async{
    if(_todoTitle.text.isNotEmpty && _todoDesc.text.isNotEmpty){

      var regBody = {

        "userId" : userId,
        "title" : _todoTitle.text,
        "desc" : _todoDesc.text
      };
      try{

      var response = await http.post(Uri.parse(storetodo),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['success']);

      if(jsonResponse['success']){
        _todoTitle.clear(); 
        _todoDesc.clear();
        Navigator.pop(context);
        getAllData(userId);
      }
      
      }catch(error){
        print(error);
      }


    }
  }
  

  void getAllData(userId) async{

       var regBody = {

        "userId" : userId,
        
      };
      try{
      
      var response = await http.post(Uri.parse(getData),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      items = jsonResponse['data'];

      print(jsonResponse['success']);
      
      setState(() {
        
      });
      }
      catch(err){
        print(err);
      }

  }

  void deleteData(id) async{

    var regBody = {

        "id" : id,
        
      };
      
      var response = await http.post(Uri.parse(deletedata),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['success']){
        getAllData(userId);
      }
      else{
        print('Somethinng Went Wrong');
      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
       body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
  padding: const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const CircleAvatar(
        child: const Icon(Icons.list, size: 25.0),
        backgroundColor: Colors.white,
        radius: 25.0,
      ),
      const SizedBox(width: 10.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child:  Row(
              children: [
                Text(
                  'ToDo App',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '${items!.length} Tasks',
            style: const TextStyle(fontSize: 20,color: Colors.black),
          ),
        ],
      ),
    ],
  ),
),



           Expanded(
             child: Container(
               decoration: const BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: items == null
                  ? const Center(child: CircularProgressIndicator()) 
                  : items!.isEmpty
                      ? const Center(child: Text('No tasks available')) : ListView.builder(
                     itemCount: items!.length,
                     itemBuilder: (context,int index){
                       return Slidable(
                         key: ValueKey(items![index]['_id']),
                         endActionPane: ActionPane(
                           motion: const ScrollMotion(),
                           dismissible: DismissiblePane(onDismissed: () {}),
                           children: [
                             SlidableAction(
                               backgroundColor: Color(0xFFFE4A49),
                               foregroundColor: Colors.white,
                               icon: Icons.delete,
                               label: 'Delete',
                               onPressed: (BuildContext context) {

                                print('${items![index]['_id']}');
                                deleteData('${items![index]['_id']}');
                                 
                               },
                             ),
                           ],
                         ),
                         child: Card(
                           borderOnForeground: false,
                           child: ListTile(
                             leading: const Icon(Icons.task),
                             title:  Text('${items![index]['title']}'),
                             subtitle: Text('${items![index]['desc']}') ,
                             trailing: const Icon(Icons.arrow_back),
                           ),
                         ),
                       );
                     }
                 ),
               ),
             ),
           )
         ],
       ),

      floatingActionButton: FloatingActionButton(
        onPressed: () =>_displayTextInputDialog(context) ,
        child: Icon(Icons.add),
        tooltip: 'Add-ToDo',
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add To-Do'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _todoTitle,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)
                          )
                          )
                          ),
                ).p4().px8(),
                TextField(
                  controller: _todoDesc,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Description",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                ).p4().px8(),
                ElevatedButton(onPressed: (){
                   addTodo();
                  }, child: const Text("Add"))
              ],
            )
          );
        }
        );
  }
}