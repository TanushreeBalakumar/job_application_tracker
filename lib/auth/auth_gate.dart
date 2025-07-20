import 'package:flutter/material.dart';
import 'package:job_app/pages/home_page.dart';
import 'package:job_app/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// This widget listens to the authentication state and shows
/// either the HomePage or LoginPage based on whether the user is logged in.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final authState = snapshot.data;
        final session = authState?.session;

        if (session != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

/// Notifies GoRouter when auth state changes (login/logout).
class AuthStateNotifier extends ChangeNotifier {
  AuthStateNotifier() {
    Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      notifyListeners();
    });
  }
}
