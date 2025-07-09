import 'package:go_router/go_router.dart';
import 'package:job_application_tracker/pages/login_page.dart';
import 'package:job_application_tracker/pages/signup_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
  ],
);