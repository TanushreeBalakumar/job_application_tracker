import 'package:flutter/material.dart';
import 'package:job_app/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final authService = AuthService();
  
  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final fullName = user?.userMetadata?['full_name'] ?? 'User';
    
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, $fullName!',
                        style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 6
                      ),
                      Text(
                        'Ready for your dream job?',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan[50],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(6),
                    child: IconButton(
                      onPressed: logout,
                      icon: Icon(Icons.logout_sharp, size: 30,)
                    ),
                  )
                ],  
              ),

              SizedBox(
                height: 25,
              ),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  borderRadius: BorderRadius.circular(6)
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 6,
                    ),
                    Text('Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          
        )
      ),
    );
  }
}