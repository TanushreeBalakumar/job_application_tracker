import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:job_app/auth/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final authService = AuthService();

  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp() async {
    final email = _emailController.text;
    final fullName = _fullNameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }

    try {
      await authService.signUpWithEmailPassword(email, password, fullName);
      if (!mounted) return;
      context.go('/login');
    } 
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    label: Icon(Icons.g_mobiledata_rounded, size: 30,),
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email ID', prefixIcon: Icon(Icons.alternate_email_rounded),
                      ),
                    ),
                    TextField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full name', prefixIcon: Icon(Icons.face),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded),
                      ),
                    ),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password', prefixIcon: Icon(Icons.lock_outline_rounded),
                      ),
                    ),
          
                    SizedBox(height: 10),
          
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: signUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent[400], 
                              padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
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
            ],
          ),
        ),
      ),
    );
  }
}