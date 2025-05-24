// widgets/server_config_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/error_receiver_view_model.dart';

class ServerConfigWidget extends StatelessWidget {
  const ServerConfigWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final urlController = TextEditingController();
    final portController = TextEditingController();
    final viewModel = context.watch<ErrorReceiverViewModel>();

    urlController.text = viewModel.serverUrl;
    portController.text = viewModel.serverPort.toString();

    return Column(
      children: [
        TextField(
          controller: urlController,
          decoration: const InputDecoration(
            labelText: 'Server Host',
            hintText: 'Enter server host (e.g. 0.0.0.0)',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: portController,
          decoration: const InputDecoration(
            labelText: 'Port',
            hintText: 'Enter port number',
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: viewModel.isServerRunning
                  ? null
                  : () {
                      viewModel.startServer(
                        host: urlController.text,
                        port: int.tryParse(portController.text),
                      );
                    },
              child: Text(
                'Start Server',
                style: TextStyle(
                  color: viewModel.isServerRunning ? Colors.grey : Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: viewModel.isServerRunning ? viewModel.stopServer : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Stop Server'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (viewModel.isServerRunning)
          Text(
            'Server running at ws://${viewModel.serverUrl}:${viewModel.serverPort}',
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
