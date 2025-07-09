import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/signup.jpg',
            width: 400,
            height: 300,
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Sign up',
                style: 
                TextStyle(color: const Color.fromARGB(255, 3, 9, 74), fontWeight: FontWeight.bold, fontSize: 30,),
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(
              height: 20
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  label: Icon(Icons.facebook, size: 30,),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    side: const BorderSide(color: Colors.black45),
                  )
                ),

                OutlinedButton.icon(
                  onPressed: () {},
                  label: Icon(Icons.facebook, size: 30,),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    side: const BorderSide(color: Colors.black45),
                  )
                ),

                OutlinedButton.icon(
                  onPressed: () {},
                  label: Icon(Icons.apple, size: 30, color: Colors.black,),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    side: const BorderSide(color: Colors.black45),
                  )
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            Text('Or, register with email...',
            style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            
            Container(
              padding: EdgeInsets.all(12),
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email ID', prefixIcon: Icon(Icons.alternate_email_rounded),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Full name', prefixIcon: Icon(Icons.face),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Education', prefixIcon: Icon(Icons.school),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          context.push('/');
                        },
                      child: Text('Login', style: TextStyle(color: const Color.fromARGB(255, 11, 70, 172), fontWeight: FontWeight.bold),)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}