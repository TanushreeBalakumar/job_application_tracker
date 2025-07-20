import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/job_application.dart';
import '../providers/riverpod_provider.dart';
import 'package:file_selector/file_selector.dart';
import 'package:job_app/providers/job_applications_provider.dart';
class CreatePage extends ConsumerStatefulWidget {
  const CreatePage({super.key});

  @override
  ConsumerState<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _statusController = TextEditingController();
  DateTime? _appliedDate;
  XFile? _selectedFile;

  bool _isLoading = false;

  Future<void> _pickFile() async {
    final typeGroup = XTypeGroup(
      label: 'files',
      extensions: ['pdf', 'png', 'jpg'],
    );

    final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

    setState(() {
      _selectedFile = file;
    });
  }

  Future<void> _addJob() async {
    if (!_formKey.currentState!.validate() || _appliedDate == null) return;

    final userId = Supabase.instance.client.auth.currentUser!.id;
    String? fileUrl;

    if (_selectedFile != null) {
      final fileBytes = await _selectedFile!.readAsBytes();
      String filePath = 'user_$userId/${_selectedFile!.name}';
      fileUrl = await ref.read(jobApplicationServiceProvider).uploadFile(filePath, fileBytes);
    }

    final newJob = JobApplication(
      id: '',
      title: _titleController.text.trim(),
      company: _companyController.text.trim(),
      status: _statusController.text.trim(),
      appliedOn: _appliedDate!,
      notes: '',
      fileUrl: fileUrl,
      userId: userId,
    );

    setState(() => _isLoading = true);

    try {
      await ref.read(jobApplicationServiceProvider).addJob(newJob);
      ref.invalidate(jobApplicationsProvider);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(title: const Text('Add Job'), backgroundColor: Colors.cyan,),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Job Title'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a job title' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _companyController,
                      decoration: const InputDecoration(labelText: 'Company Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a company name' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _statusController,
                      decoration: const InputDecoration(labelText: 'Status'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter status' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(_appliedDate == null
                            ? 'Pick Date'
                            : 'Date: ${_appliedDate!.toLocal().toIso8601String().substring(0, 10)}'),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() => _appliedDate = pickedDate);
                            }
                          },
                          child: const Text('Select Date'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _pickFile,
                      child: const Text('Pick Resume / File'),
                    ),
                    if (_selectedFile != null)
                      Text('Picked: ${_selectedFile!.name}'),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _addJob,
                      child: const Text('Add Job'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
