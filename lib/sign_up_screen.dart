import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: ListView(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 15),
                child: TextField(
                  controller: nameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: TextStyle(
                        fontSize: 17,
                        //color: Colors.indigo,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 15, left: 15),
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "name@example.com",
                    labelText: "E-mail address",
                    labelStyle: TextStyle(
                        fontSize: 17,
                        //color: Colors.indigo,
                        fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, right: 15, left: 15),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    helperText: "Password must be at least 6 characters",
                    helperStyle: TextStyle(fontSize: 15),
                    labelStyle: TextStyle(
                        fontSize: 17,
                        //color: Colors.indigo,
                        fontWeight: FontWeight.bold),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {
                    // get name, email, password
                    print(nameController.text);
                    print(emailController.text);
                    print(passwordController.text);

                    // send to Firebase for authentication

                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      print("Sign up was successful");
                      signUpSuccessful(context);
                      FirebaseDatabase.instance
                          .reference()
                          .child('Users/' + value.user!.uid + "/Profile")
                          .set({
                        'name': nameController.text,
                        'email': emailController.text
                      });
                      Navigator.pop(context); // go back to previous screen
                    }).catchError((error) {
                      print("Sign up failed");
                      print(error.toString());
                      signUpFailed(context);
                    });
                  },
                  child: Text('Confirm'),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  void signUpSuccessful(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("Sign up was successful"),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void signUpFailed(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("Sign up failed"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
