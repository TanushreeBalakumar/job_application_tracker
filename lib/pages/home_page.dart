import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                        'Hi, UserName!',
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
                      onPressed: () {
                        context.push('/');
                      },
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