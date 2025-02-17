import 'package:flutter/material.dart';
import 'package:flutter_dmcb_logger/print/print_entity.dart';
import 'package:flutter_dmcb_logger/print/print_type.dart';

class PrintCell extends StatefulWidget {
  final PrintEntity data;

  const PrintCell({super.key, required this.data});

  @override
  State<PrintCell> createState() => _PrintCellState();
}

class _PrintCellState extends State<PrintCell> {
  PrintEntity get item => widget.data;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 8, right: 8),
      childrenPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
      title: Text(
        "${item.type.tabFlag()} [date: ${item.startTime.toString()}]",
        style: TextStyle(fontSize: 14, color: item.type.color()),
      ),
      subtitle: Text(
        'title: ${item.title}',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 14,
          color: item.type.color(),
        ),
      ),
      expandedAlignment: Alignment.centerLeft,
      children: [
        SelectableText(
          item.content,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 14, color: item.type.color()),
        )
      ],
    );
  }
}
