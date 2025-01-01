import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'error_tracking_state.dart';

class ErrorTrackingCubit extends Cubit<ErrorTrackingState> {
  ErrorTrackingCubit() : super(ErrorTrackingInitial());
}
