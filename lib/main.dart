import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/Services/AuthenticationService.dart';
import 'package:flutter/gestures.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Login(),
  ));
}


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _controller = TextEditingController();
  final _passController = TextEditingController();
  String name = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  final AuthenticationServices _auth = AuthenticationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child:
              Image(image: AssetImage('assets/login-splash.png'), height: 200, width: 200),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            TextFormField(
              controller: _controller,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),                   
                        ),
                        onChanged: (String namee) {
                          setState(() {
                            name = namee;
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
                  password = passwordd;
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
                    "LOGIN",
                    style: TextStyle(color: Colors.black, fontSize: 18, letterSpacing: 2),
                    ),
                  onPressed: () {
                    if(_formKey.currentState!.validate())
                    {
                      loginUser();
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
              SizedBox(height: 10,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Don\'t have an account? ', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 2)),
                        TextSpan(text: 'Sign Up', style: TextStyle(color: Colors.blueAccent, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 2), recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        },)
                      ]
                    ),
                    
                  )
                ),
              ),
            ],
          )
        ],
      ),
      ),
    );
  }

  void loginUser() {
    dynamic result = _auth.signInWithEmailAndPassword(_controller.text, _passController.text);
    if(result == null)
    {
      print('Sign error.');
    }
    else
    {
    _controller.clear();
    _passController.clear();
    print('Successfully signed in.');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }

  }
}
