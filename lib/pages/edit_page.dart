import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_application.dart';
import '../providers/riverpod_provider.dart';
import 'package:job_app/providers/job_applications_provider.dart';

class EditPage extends ConsumerStatefulWidget {
  final JobApplication job;
  const EditPage({super.key, required this.job});

  @override
  ConsumerState<EditPage> createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  late TextEditingController _titleController;
  late TextEditingController _companyController;
  late TextEditingController _statusController;
  DateTime? _appliedDate;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.job.title);
    _companyController = TextEditingController(text: widget.job.company);
    _statusController = TextEditingController(text: widget.job.status);
    _appliedDate = widget.job.appliedOn;
  }

  Future<void> _updateJob() async {
    if (_titleController.text.isEmpty ||
        _companyController.text.isEmpty ||
        _statusController.text.isEmpty ||
        _appliedDate == null){ return;}

    final updatedJob = JobApplication(
      id: widget.job.id,
      title: _titleController.text.trim(),
      company: _companyController.text.trim(),
      status: _statusController.text.trim(),
      appliedOn: _appliedDate!,
      notes: widget.job.notes,
      fileUrl: widget.job.fileUrl,
      userId: widget.job.userId,
    );

    setState(() => _isLoading = true);

    try {
      await ref.read(jobApplicationServiceProvider).updateJob(updatedJob);
      ref.invalidate(jobApplicationsProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Job')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Job Title'),
                  ),
                  TextFormField(
                    controller: _companyController,
                    decoration: const InputDecoration(labelText: 'Company Name'),
                  ),
                  TextFormField(
                    controller: _statusController,
                    decoration: const InputDecoration(labelText: 'Status'),
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
                            initialDate: _appliedDate ?? DateTime.now(),
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
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _updateJob,
                    child: const Text('Update Job'),
                  )
                ],
              ),
            ),
    );
  }
}
