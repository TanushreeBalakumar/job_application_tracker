import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth_service.dart';
import '../providers/job_applications_provider.dart';
import '../models/job_application.dart';
import 'package:job_app/pages/edit_page.dart';
import 'package:job_app/providers/riverpod_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:job_app/pages/create_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void logout() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Supabase.instance.client.auth.currentUser;
    final fullName = user?.userMetadata?['full_name'] ?? 'User';
    final jobsAsync = ref.watch(jobApplicationsProvider);

    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, $fullName!',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: IconButton(
                      onPressed: logout,
                      icon: const Icon(Icons.logout_sharp, size: 30),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Container(
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    SizedBox(width: 6),
                    Text('Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// Jobs List 
              Expanded(
                child: jobsAsync.when(
                  data: (jobs) {
                    if (jobs.isEmpty) {
                      return const Center(child: Text('No job applications found.'));
                    }
                    return ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final JobApplication job = jobs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(job.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${job.company} • ${job.status}'),
                                if (job.fileUrl != null)
                                  TextButton(
                                    onPressed: () {
                                      launchUrl(Uri.parse(job.fileUrl!));
                                    },
                                    child: const Text('Download Resume'),
                                  ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditPage(job: job),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Confirm'),
                                        content: const Text('Do you want to delete this job?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      await ref
                                          .read(jobApplicationServiceProvider)
                                          .deleteJob(job.id);
                                      ref.invalidate(jobApplicationsProvider); 
                                    }
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditPage(job: job),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Error: $error')),
                ),
              ),

              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreatePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
