import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_app/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://llaxtmaszzhmbtqaqzfo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxsYXh0bWFzenpobWJ0cWFxemZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIzODQ2MDIsImV4cCI6MjA2Nzk2MDYwMn0.b2pj-DOvu-gIC7zUzPiLkWj0NX1e-SiBz1tuCiIDjf0',
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
