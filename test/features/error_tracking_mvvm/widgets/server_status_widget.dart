// widgets/server_status_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/error_receiver_view_model.dart';
import 'sever_config_widget.dart';

class ServerStatusWidget extends StatelessWidget {
  const ServerStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ErrorReceiverViewModel>(
      builder: (context, viewModel, _) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Server Status: ${viewModel.isServerRunning ? "Running" : "Stopped"}',
                    ),
                    Text('Connections: ${viewModel.connectionCount}'),
                  ],
                ),
                if (viewModel.lastError != null)
                  Text(
                    viewModel.lastError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 16),
                const ServerConfigWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
