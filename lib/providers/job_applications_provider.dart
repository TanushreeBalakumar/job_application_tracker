import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_application.dart';
import 'riverpod_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final jobApplicationsProvider = FutureProvider.autoDispose<List<JobApplication>>((ref) async {
  final jobService = ref.read(jobApplicationServiceProvider);
  final userId = ref.read(supabaseClientProvider).auth.currentUser?.id ?? '';
  return await jobService.getJobsByUser(userId);
});

final supabaseClientProvider = Provider((ref) => Supabase.instance.client);
