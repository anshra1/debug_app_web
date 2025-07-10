import 'dart:io';

import 'package:debug_app_web/ai_error/to_ai.dart';
import 'package:debug_app_web/ai_error/fingerprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

enum ErrorType {
  formatException('FormatException (Exception)'),
  stateError('StateError (Error)'),
  argumentError('ArgumentError (Error)'),
  rangeError('RangeError (Error)');

  const ErrorType(this.displayName);
  final String displayName;
}

class ErrorToAITestPage extends StatefulWidget {
  const ErrorToAITestPage({super.key});

  @override
  State<ErrorToAITestPage> createState() => _ErrorToAITestPageState();
}

class _ErrorToAITestPageState extends State<ErrorToAITestPage> {
  final _errorToAI = ToAI();
  final _solutionController = TextEditingController();

  String _status = 'Initialized and ready.';
  String _lastFingerprint = '';
  String _indexContent = '';
  String _clipboardContent = '';
  ErrorType _selectedError = ErrorType.formatException;

  final String _baseDirectory =
      '/home/ansh/Studio Projects/Clone/debug_app_web/bug-fingerprint';

  @override
  void initState() {
    super.initState();
    _refreshStatus();
  }

  @override
  void dispose() {
    _solutionController.dispose();
    super.dispose();
  }

  Future<void> _refreshStatus() async {
    final indexFile = File(p.join(_baseDirectory, 'index.json'));
    if (indexFile.existsSync()) {
      _indexContent = await indexFile.readAsString();
    } else {
      _indexContent = 'index.json not found.';
    }

    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    _clipboardContent = clipboardData?.text ?? 'Clipboard is empty.';

    setState(() {});
  }

  Future<void> _generateTestError() async {
    try {
      // Use a consistent error to always generate the same fingerprint
      switch (_selectedError) {
        case ErrorType.formatException:
          throw const FormatException('This is a test FormatException.');
        case ErrorType.stateError:
          throw StateError('This is a test StateError.');
        case ErrorType.argumentError:
          throw ArgumentError('This is a test ArgumentError on purpose.');
        case ErrorType.rangeError:
          throw RangeError('This is a test RangeError.');
      }
    } catch (e, stackTrace) {
      _lastFingerprint = FingerprintGenerator.generateFingerprint(e);
      setState(() {
        _status = 'Generated fingerprint: $_lastFingerprint';
      });

      await _errorToAI.sendError(
        error: e,
        stackTrace: stackTrace,
        additionalInformation:
            'Test error generated at ${DateTime.now().toIso8601String()}',
      );

      setState(() {
        _status =
            'sendError completed for fingerprint: $_lastFingerprint.\nCheck logs and clipboard.';
      });
      await _refreshStatus();
    }
  }

  Future<void> _addSolution() async {
    if (_lastFingerprint.isEmpty) {
      setState(() {
        _status = 'Please generate an error first to get a fingerprint.';
      });
      return;
    }
    if (_solutionController.text.isEmpty) {
      setState(() {
        _status = 'Please enter a solution text.';
      });
      return;
    }

    await _errorToAI.addSolution(
      fingerprint: _lastFingerprint,
      solution: _solutionController.text,
    );

    setState(() {
      _status = 'addSolution completed for fingerprint: $_lastFingerprint.';
      _solutionController.clear();
    });
    await _refreshStatus();
  }

  Future<void> _reset() async {
    try {
      final dir = Directory(_baseDirectory);
      if (dir.existsSync()) {
        await dir.delete(recursive: true);
        setState(() {
          _status = 'bug-fingerprint directory has been deleted.';
          _lastFingerprint = '';
          _indexContent = '';
        });
      }
      // Re-initialize
      ToAI();
      await _refreshStatus();
    } catch (e) {
      setState(() {
        _status = 'Error resetting directory: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ErrorToAI Test Runner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshStatus,
            tooltip: 'Refresh Status',
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _reset,
            tooltip: 'Reset (Deletes Directory)',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Controls'),
            _buildErrorDropdown(),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _generateTestError,
              child: const Text('1. Generate Test Error'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _solutionController,
              decoration: const InputDecoration(
                labelText: 'Enter Solution Text Here',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addSolution,
              child: const Text('2. Add Solution for Last Error'),
            ),
            const Divider(height: 32),
            _buildSectionTitle('Status & Info'),
            _buildInfoCard('Status', _status),
            _buildInfoCard('Last Fingerprint', _lastFingerprint, selectable: true),
            _buildInfoCard(
              'Clipboard Content',
              _clipboardContent.split('\n').first,
              selectable: true,
            ),
            _buildInfoCard('index.json Content', _indexContent),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, {bool selectable = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            if (selectable)
              SelectableText(
                content,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black87),
              )
            else
              Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black87),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ErrorType>(
          value: _selectedError,
          isExpanded: true,
          onChanged: (ErrorType? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedError = newValue;
                _status = 'Selected error: ${newValue.displayName}';
              });
            }
          },
          items: ErrorType.values.map((ErrorType error) {
            return DropdownMenuItem<ErrorType>(
              value: error,
              child: Text(error.displayName),
            );
          }).toList(),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ErrorToAI Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ErrorToAITestPage(),
    );
  }
}
