import 'package:flutter/material.dart';
import 'package:flutter_dmcb_logger/net/net_view.dart';
import 'package:flutter_dmcb_logger/print/print_view.dart';

class DLoggerListPage extends StatelessWidget {
  const DLoggerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xfff3f3f3),
        appBar: AppBar(
          backgroundColor: const Color(0xfff3f3f3),
          foregroundColor: Colors.black,
          title: const Text('Logger'),
          bottom: const TabBar(
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black,
            isScrollable: false,
            indicatorColor: Colors.transparent,
            indicatorWeight: 3,
            tabs: [
              Tab(child: Text("Log")),
              Tab(child: Text("Net")),
            ],
          ),
          elevation: 0,
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              PrintView(),
              NetView(),
            ],
          ),
        ),
      ),
    );
  }
}
