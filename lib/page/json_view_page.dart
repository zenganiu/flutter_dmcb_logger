import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dmcb_logger/json_view/json_view.dart';

class DJsonViewPage extends StatefulWidget {
  final String title;
  final String jsonString;
  const DJsonViewPage({super.key, this.title = 'json', this.jsonString = ''});

  @override
  State<DJsonViewPage> createState() => _DJsonViewPageState();
}

class _DJsonViewPageState extends State<DJsonViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: _buildJsonView(),
      ),
    );
  }

  Widget _buildJsonView() {
    final child = canConvertToObject(widget.jsonString)
        ? JsonView(json: json.decode(widget.jsonString))
        : SingleChildScrollView(
            child: Text(
              widget.jsonString,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          );
    return Padding(
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }

  bool canConvertToObject(String jsonString) {
    try {
      if (json.decode(jsonString) is Map<String, dynamic>) {
        return true;
      } else if (json.decode(jsonString) is List) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
