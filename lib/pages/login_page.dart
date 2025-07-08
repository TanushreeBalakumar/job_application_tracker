import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column( 
          children: [
            //Image
            Image.asset('login.jpg',
            width: 350,
            height: 350,),
            //Login
            Text(
              'Login',
              style: TextStyle(color: const Color.fromARGB(255, 3, 9, 74), fontWeight: FontWeight.bold, fontSize: 24,),
              textAlign: TextAlign.start, 
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(12)
              ),
              
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.alternate_email_rounded),
                  SizedBox(width: 10),
                  Text('Email ID')
                ]
              )
            ),
            SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(12)
              ),
              
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.lock_outline_rounded),
                  SizedBox(width: 10),
                  Text('Password'),
                  SizedBox(width: 40),
                  Text('Forgot?', style: TextStyle(color: Colors.blue),)
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
}