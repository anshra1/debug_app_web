// screens/error_receiver_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/error_receiver_view_model.dart';
import '../widgets/error_list_widget.dart';
import '../widgets/server_status_widget.dart';

class ErrorReceiverScreen extends StatelessWidget {
  const ErrorReceiverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Receiver'),
        actions: [
          Consumer<ErrorReceiverViewModel>(
            builder: (context, viewModel, _) {
              return IconButton(
                icon: Icon(
                  viewModel.isServerRunning ? Icons.stop : Icons.play_arrow,
                ),
                onPressed: () {
                  if (viewModel.isServerRunning) {
                    viewModel.stopServer();
                  } else {
                    viewModel.startServer();
                  }
                },
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          ServerStatusWidget(),
          Expanded(child: ErrorListWidget()),
        ],
      ),
    );
  }
}
