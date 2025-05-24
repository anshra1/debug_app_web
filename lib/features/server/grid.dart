import 'package:debug_app_web/features/server/web_error_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebRoot extends StatelessWidget {
  const WebRoot({required this.child, required this.ip, required this.port, super.key});

  final Widget child;
  final String ip;
  final int port;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WebErrorManager()),
      ],
      child: WebDotWidget(
        ip: ip,
        port: port,
        child: child,
      ),
    );
  }
}

class WebDotWidget extends StatefulWidget {
  const WebDotWidget({
    required this.child,
    required this.ip,
    required this.port,
    super.key,
  });

  final Widget child;
  final String ip;
  final int port;

  @override
  State<WebDotWidget> createState() => _WebDotWidgetState();
}

class _WebDotWidgetState extends State<WebDotWidget> {
  @override
  void initState() {
    WebErrorManager.platform.initConnection(ip: widget.ip, port: widget.port);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Consumer<WebErrorManager>(
          builder: (context, analytics, child) {
            return Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      try {
                        // Simulate some operation that might throw an error
                        throw Exception('This is a test exception');
                      } on Exception catch (e) {
                        debugPrint('Caught an exception: $e');
                      }
                    },
                    child: const Text('Click me'),
                  ),
                  
                  
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
