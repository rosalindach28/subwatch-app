import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
class LoginOrSignUpPage extends StatefulWidget {
  LoginOrSignUpPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginOrSignUpPageState createState() => _LoginOrSignUpPageState();
}

class _LoginOrSignUpPageState extends State<LoginOrSignUpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 40, bottom: 20),
                child: Text( 'SubWatch',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )
                ),

            ),

            // Login Button
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 22,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(title: 'Log in',)),
                );
              },
              child: Text(
                  'Log in'
              ),
            ),
        ),
            // Sign Up button here
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 22,
                ),

              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage(title: 'Sign Up',)),
                );
              },
              child: Text(
                  'Sign Up'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
