
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework/constants.dart';
import 'post_assignment_screen.dart';

class Assignments extends StatefulWidget {
  static const String id =   'assignmentRoute';

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  final _firestore = FirebaseFirestore.instance.collection('PostQuestions');

 late Stream<QuerySnapshot> _postStreams;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postStreams = _firestore.snapshots();
  }
  @override
  Widget build(BuildContext context) {
    _firestore.get();
    _firestore.snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text('HOME WORK APP'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _postStreams,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          if(snapshot.connectionState== ConnectionState.active){
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> listQueryDocumentSnapshot = querySnapshot.docs;
             return ListView.builder(
                 itemCount: listQueryDocumentSnapshot.length,
                 itemBuilder: (context,index){
                   QueryDocumentSnapshot documentSnapshot = listQueryDocumentSnapshot[index];
                   return Expanded(
                       
                       child: Card(
                         elevation: 10,
                         child: Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                           Text(documentSnapshot['userName'],style: TextStyle(
                            fontSize: 17,
                             fontWeight: FontWeight.bold

                           ),),
                            Text('Subject: ${documentSnapshot['subject']}',style: kTextStlye.copyWith(fontStyle: FontStyle.italic),),
                           Center(child: Container(
                             height: 100,
                               child: Text(documentSnapshot['question']))),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.end,
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Card(
                                 elevation: 20,
                                   child: Text('Ghc ${documentSnapshot['price']}',style:
                                   TextStyle(color: Colors.red,
                                   fontWeight: FontWeight.bold),)),
                             ],
                           ),
                       Container(child: Row(

                         children: [
                           ElevatedButton(onPressed: (){}, child: Text("ACCEPT")),
                           IconButton(onPressed: (){}, icon: Icon(Icons.star)),
                           IconButton(onPressed: (){}, icon: Icon(Icons.comment)),
                           IconButton(onPressed: (){}, icon: Icon(Icons.child_care_outlined)),

                         ],),)


                     ],
                   ),
                         ),
                       ));

                 });
          }
          return CircularProgressIndicator();
          }
      ),
      floatingActionButton:      FloatingActionButton(onPressed: (){
        Navigator.of(context).pushReplacementNamed(Post_Assignment.id);
      },
    child: Icon(Icons.add_comment_rounded),)
    );
  }
}
