import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'job_database.dart';

final jobApplicationServiceProvider = Provider<JobApplicationService>((ref) {
  return JobApplicationService();
});
