import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:job_app/models/job_application.dart';


class JobApplicationService {
  final supabase = Supabase.instance.client;
  final String tableName = 'job_applications';

  // Create
  Future<void> addJob(JobApplication job) async {
    await supabase.from(tableName).insert(job.toJson());
  }

  // Read 
  Future<List<JobApplication>> getJobsByUser(String userId) async {
    final response = await supabase
        .from(tableName)
        .select()
        .eq('user_id', userId)
        .order('applied_on', ascending: false);
    return (response as List)
        .map((e) => JobApplication.fromJson(e))
        .toList();
  }

  /// Update
  Future<void> updateJob(JobApplication job) async {
    await supabase
        .from(tableName)
        .update(job.toJson())
        .eq('id', job.id);
  }

  /// Delete
  Future<void> deleteJob(String id) async {
    await supabase.from(tableName).delete().eq('id', id);
  }

  Future<String?> uploadFile(String path, Uint8List fileData) async {
  final storage = Supabase.instance.client.storage;

  // Upload the file directly
  await storage.from('resumes').uploadBinary(
    path,
    fileData,
    fileOptions: const FileOptions(upsert: true),
  );

  // Return the public URL
  final publicUrl = storage.from('resumes').getPublicUrl(path);
  return publicUrl;
  }
}
