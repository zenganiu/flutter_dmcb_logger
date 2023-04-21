import 'package:flutter/material.dart';
import 'package:flutter_dmcb_logger/flutter_dmcb_logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DOverlayDebugView.show(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    DLogger.info('213312', title: 'info');
                    DLogger.debug('123132', title: 'debug');
                    DLogger.warn('123132', title: 'warn');
                    DLogger.error('123123', title: 'error');
                  },
                  child: const Text('print log'),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    DLogger.net(api: 'api');
                  },
                  child: const Text('net log'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
