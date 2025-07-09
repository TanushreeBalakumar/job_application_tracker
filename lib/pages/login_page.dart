import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image
            Image.asset('assets/login.jpg',
            width: 400,
            height: 300,
            ),

            Container(
              padding: EdgeInsets.all(12),
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login',
                      style: TextStyle(color: const Color.fromARGB(255, 3, 9, 74), fontWeight: FontWeight.bold, fontSize: 30,), 
                    ),
                  ),

                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email ID', prefixIcon: Icon(Icons.alternate_email_rounded),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded), 
                      suffix: TextButton(
                        onPressed:() {},
                        child: Text('Forget?',
                        style: TextStyle(
                          color: Colors.blueAccent[400]),
                        ),
                     ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent[400], 
                padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Or, login with...'),
            SizedBox(
              height: 20,
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
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New to JobApplicationTracker?'),
                TextButton(
                  onPressed: () {
                    context.push('/signup');
                  },
                  child: Text('Register', style: TextStyle(color: const Color.fromARGB(255, 11, 70, 172), fontWeight: FontWeight.bold),)),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}