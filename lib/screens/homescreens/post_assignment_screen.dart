
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homework/screens/homescreens/assignments_screen.dart';


final _firestore = FirebaseFirestore.instance;

final TextEditingController subjectController = TextEditingController();
final TextEditingController userNameController = TextEditingController();
final TextEditingController questionController = TextEditingController();
final TextEditingController priceController = TextEditingController();

class Post_Assignment extends StatefulWidget {
  static const String id =   'post_AssignmentRoute';

  @override
  State<Post_Assignment> createState() => _Post_AssignmentState();
}

class _Post_AssignmentState extends State<Post_Assignment> {


  @override
  Widget build(BuildContext context) {
    final userNameField =TextFormField(
      autofocus: false,
      controller: userNameController,
      keyboardType: TextInputType.text,
      // validator: (value){},
      onSaved: (value){
        userNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Username',
        prefixIcon: Icon(Icons.accessibility_sharp,),
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

      ),
    );
    final subjectField = TextFormField(
      autofocus: false,
      controller: subjectController,
      keyboardType: TextInputType.text,
      // validator: (value){},
      onSaved: (value){
        subjectController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Type Assignment Suject Area',
        prefixIcon: Icon(Icons.question_mark,),
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

      ),
    );
    final questionField = TextFormField(
      maxLines: 15,
      autofocus: false,
      controller: questionController,
      keyboardType: TextInputType.text,
      // validator: (value){},
      onSaved: (value){
        questionController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Compose question/assignment',
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

      ),
    );
    final priceField = TextFormField(
      autofocus: false,
      controller: priceController,
      keyboardType: TextInputType.number,
      // validator: (value){},
      onSaved: (value){
        priceController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Ghc',
        labelStyle: TextStyle(color: Colors.red) ,
        hintText: 'Tag Price',
        prefixIcon: Icon(Icons.money,color: Colors.red,),
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white70,
        title: Text('Create Post', style: TextStyle(color: Colors.black),),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: ActionChip(label: Text('POST',style: TextStyle(color: Colors.green),),
            onPressed: (){
            _firestore.collection('PostQuestions').add({
              'userName': userNameController.text,
              'subject': subjectController.text,
              'question': questionController.text,
              'price': priceController.text
            });
            Navigator.of(context).pushReplacementNamed(Assignments.id);
            },

          ),
        ),],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            SizedBox(height: 10,),
            userNameField,
            SizedBox(height: 10,),
            subjectField,
            SizedBox(height: 10,),
            questionField,
            Container(height: 120,
            ),
            Container(
                width: 200,
                child: priceField),
            GestureDetector(
              onTap: (){
              },
              child: Card(
                elevation: 20,
                child: ListTile(
                  leading: Icon(Icons.file_download,color: Colors.green,),
                  title: Text('Attach File',style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),),
                  trailing: Icon(Icons.import_export),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Card(
                elevation: 20,
                child: ListTile(
                  leading: Icon(Icons.add_a_photo,color: Colors.green,),
                  title: Text('Attach Picture',style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),),
                  trailing: Icon(Icons.import_export),
                ),
              ),
            )
          ],)
        ,),)
    );
  }
}
