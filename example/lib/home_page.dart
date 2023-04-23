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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('日志总开关'),
                  Switch(
                    value: DLogger.enabled,
                    onChanged: (st) {
                      DLogger.setLogEnabled(st);
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('console log'),
                  Switch(
                    value: DLogger.config.hasPrintLog,
                    onChanged: (st) {
                      DLogger.setLogConfig(hasPrintLog: st);
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('write log'),
                  Switch(
                    value: DLogger.config.hasWriteLog,
                    onChanged: (st) {
                      DLogger.setLogConfig(hasWriteLog: st);
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('net log'),
                  Switch(
                    value: DLogger.config.hasPrintNet,
                    onChanged: (st) {
                      DLogger.setLogConfig(hasPrintNet: st);
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('write net'),
                  Switch(
                    value: DLogger.config.hasWriteNet,
                    onChanged: (st) {
                      DLogger.setLogConfig(hasWriteNet: st);
                      setState(() {});
                    },
                  ),
                ],
              ),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    DLogger.info('info123456', title: 'info');
                    DLogger.debug('debug654', title: 'debug');
                    DLogger.warn('warn963', title: 'warn');
                    DLogger.error('error741', title: 'error');
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
