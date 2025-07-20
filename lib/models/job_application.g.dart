// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobApplication _$JobApplicationFromJson(Map<String, dynamic> json) =>
    JobApplication(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      status: json['status'] as String,
      appliedOn: DateTime.parse(json['applied_on'] as String),
      notes: json['notes'] as String?,
      fileUrl: json['file_url'] as String?,
      userId: json['user_id'] as String,
    );

/*Map<String, dynamic> _$JobApplicationToJson(JobApplication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'status': instance.status,
      'applied_on': instance.appliedOn.toIso8601String(),
      'notes': instance.notes,
      'file_url': instance.fileUrl,
      'user_id': instance.userId,
    };
*/