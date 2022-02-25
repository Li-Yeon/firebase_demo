import 'package:firebase_demo/Services/AuthenticationService.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final AuthenticationServices _auth = AuthenticationServices();

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
      body: ListView.builder(itemCount: 1, itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title:Text('Grab Food'),
            subtitle: Text('RM17.00'),
            trailing: Icon(Icons.money_off),
          )
        );
      })
    );
  }
}