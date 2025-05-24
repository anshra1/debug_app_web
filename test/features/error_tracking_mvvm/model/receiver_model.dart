// models/received_error_model.dart
import '../../../src2/features/error_tracking/data/models/current_error_details_model.dart';

class ReceivedErrorModel {
  ReceivedErrorModel({
    required this.errorDetails,
    required this.receivedAt,
    required this.deviceInfo,
  });

  factory ReceivedErrorModel.fromJson(Map<String, dynamic> json) {
    return ReceivedErrorModel(
      errorDetails: ErrorDetailsModel.fromJson(json['data'] as Map<String, dynamic>),
      receivedAt: DateTime.parse(json['timestamp'] as String),
      deviceInfo: json['deviceInfo'] as String? ?? 'Unknown Device',
    );
  }
  
  final ErrorDetailsModel errorDetails;
  final DateTime receivedAt;
  final String deviceInfo;
}
