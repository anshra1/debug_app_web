// widgets/error_list_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/receiver_model.dart';
import '../viewmodels/error_receiver_view_model.dart';

class ErrorListWidget extends StatelessWidget {
  const ErrorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ErrorReceiverViewModel>(
      builder: (context, viewModel, _) {
        return ListView.builder(
          itemCount: viewModel.errors.length,
          itemBuilder: (context, index) {
            final error = viewModel.errors[index];
            return ErrorListItem(error: error);
          },
        );
      },
    );
  }
}

class ErrorListItem extends StatelessWidget {
  const ErrorListItem({required this.error, super.key});
  final ReceivedErrorModel error;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(error.errorDetails.rootCauseName),
      subtitle: Text(
        'Received: ${DateFormat.yMd().add_Hms().format(error.receivedAt)}',
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Device: ${error.deviceInfo}'),
              const SizedBox(height: 8),
              Text('Line: ${error.errorDetails.rootCauseLineNumber}'),
              const SizedBox(height: 8),
              Text('Stack Trace:',
                  style: Theme.of(context).textTheme.titleSmall,),
              Text(error.errorDetails.stackTrace),
            ],
          ),
        ),
      ],
    );
  }
}
