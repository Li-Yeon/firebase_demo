import 'package:firebase_demo/Services/AuthenticationService.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.lightBlue[800],
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
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))
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
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))
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
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),               
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                    style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2),
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    elevation: 5
                  )           
                )
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
      Navigator.pop(context);
    }
  }
}