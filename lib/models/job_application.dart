import 'package:json_annotation/json_annotation.dart';

part 'job_application.g.dart';

@JsonSerializable()
class JobApplication {
  final String id;
  final String title;
  final String company;
  final String status;
  @JsonKey(name: 'applied_on')
  final DateTime appliedOn;
  final String? notes;
  @JsonKey(name: 'file_url')
  final String? fileUrl;
  @JsonKey(name: 'user_id')
  final String userId;

  JobApplication({
    required this.id,
    required this.title,
    required this.company,
    required this.status,
    required this.appliedOn,
    this.notes,
    this.fileUrl,
    required this.userId,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationFromJson(json);

  //Map<String, dynamic> toJson() => _$JobApplicationToJson(this);
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'status': status,
      'applied_on': appliedOn.toIso8601String().substring(0, 10), // ✅ Correct Date Format
      'notes': notes,
      'file_url': fileUrl,
      'user_id': userId,
    };
  }
}
