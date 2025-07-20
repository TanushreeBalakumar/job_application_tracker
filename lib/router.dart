import 'package:go_router/go_router.dart';
import 'package:job_app/pages/home_page.dart';
import 'package:job_app/pages/login_page.dart';
import 'package:job_app/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:job_app/auth/auth_gate.dart';
import 'package:job_app/pages/create_page.dart';

final authStateNotifier = AuthStateNotifier();

final GoRouter router = GoRouter(
  refreshListenable: authStateNotifier,
  initialLocation: '/login',
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;
    final location = state.uri.toString();

    final loggingIn = location == '/login' || location == '/signup';

    if (!isLoggedIn) return loggingIn ? null : '/login';
    if (isLoggedIn && loggingIn) return '/home';
    return null;
  },
  
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => const CreatePage(),
    ),
  ],
);
