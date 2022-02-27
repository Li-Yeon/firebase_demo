import 'package:firebase_demo/Services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'DatabaseManager/DatabaseManager.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _fullnameController = TextEditingController();  
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String _fullName = "";
  String _name = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();

  final AuthenticationServices _auth = AuthenticationServices();
  final DatabaseManager _db = DatabaseManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _fullnameController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40))
                        ),
                        onChanged: (String namee) {
                          setState(() {
                            _fullName = namee;
                          });
                        },
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your full name!';
                      }
                      return null;
                    },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40))
                        ),
                        onChanged: (String namee) {
                          setState(() {
                            _name = namee;
                          });
                        },
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter your email!';
                      }
                      return null;
                    },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),               
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              obscureText: true,
              onChanged: (String passwordd) {
                setState(() {
                  _password = passwordd;
                },
                );
              },
              validator: (value){
                if(value!.isEmpty)
                {
                  return 'Please enter your password!';
                }
                return null;
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: ElevatedButton(
                  child: Text(
                    "REGISTER",
                    style: TextStyle(color: Colors.black, fontSize: 18, letterSpacing: 2),
                    ),
                  onPressed: () {
                    if(_formKey.currentState!.validate())
                    {
                      createUser();
                    }
                    else
                    {
                      print("Invalid");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.black),
                        ),
                  
                    ),
                  ),
                  ),           
                ),
            ],
          )
        ],
      ),
      ),
    );
  }

  void createUser() async{
    dynamic result = await _auth.createNewUser(_emailController.text, _passController.text);
    if(result == null)
    {
      print("Email is not valid");
    }
    else
    {
      print(result.toString());
      _fullnameController.clear();
      _emailController.clear();
      _passController.clear();
      await _db.createUser(name: _fullName);
      Navigator.pop(context);
    }
  }
}