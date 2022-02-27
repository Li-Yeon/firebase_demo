import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/DatabaseManager/DatabaseManager.dart';
import 'package:firebase_demo/Services/AuthenticationService.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final AuthenticationServices _auth = AuthenticationServices();
  Stream<List<User>> readUsers() => FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut().then((result) {
              print('Succesfully signed out.');
              Navigator.pop(context);
              });             
            },
          ),
        ],
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final users = snapshot.data!;
            return ListView (
              children: users.map(buildUser).toList(),
            );
          }
          else
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
  Widget buildUser(User user) {
    return Card(
        child: ListTile(
            title:Text(user.name),
            subtitle: Text('RM17.00'),
            trailing: Icon(Icons.money_off),
          )
    );
  }
}