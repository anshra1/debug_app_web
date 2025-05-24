import 'package:equatable/equatable.dart';

class ErrorEnvironment extends Equatable {
  const ErrorEnvironment({
    required this.projectName,
    required this.flutterVersion,
    required this.dartVersion,
    required this.platform,
    this.osVersion,
    this.deviceModel,
    this.additionalInfo = const {},
  });

  final List<String>? projectName;
  final List<String>? flutterVersion;
  final List<String>? dartVersion;
  final List<String>? platform;
  final List<String>? osVersion;
  final List<String>? deviceModel;
  final Map<String, dynamic> additionalInfo;

  @override
  List<Object?> get props => [
        projectName,
        flutterVersion,
        dartVersion,
        platform,
        osVersion,
        deviceModel,
        additionalInfo,
      ];
}
