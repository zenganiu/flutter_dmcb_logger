import 'package:flutter/material.dart';

import '../models/json_config_data.dart';
import 'json_config.dart';
import 'json_view.dart';
import 'simple_tiles.dart';

class IndexRange {
  final int start;
  final int end;
  IndexRange({
    required this.start,
    required this.end,
  });

  int get length => end - start;
}

class ListTile extends StatefulWidget {
  final String keyName;
  final List items;
  final IndexRange range;
  final bool expanded;
  final int depth;
  const ListTile({
    Key? key,
    required this.keyName,
    required this.items,
    required this.range,
    this.expanded = false,
    required this.depth,
  }) : super(key: key);

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
  bool _init = false;
  bool _expanded = false;

  String get _value {
    if (widget.items.isEmpty) return '[]';
    if (_expanded) return '';
    if (widget.items.length == 1) return '[0]';
    if (widget.items.length == 2) return '[0,1]';
    return '[${widget.range.start} ... ${widget.range.end}]';
  }

  void _changeState() {
    if (widget.items.isNotEmpty) {
      setState(() {
        _expanded = !_expanded;
      });
    }
  }

  int get _gap => JsonConfig.of(context).gap ?? JsonConfigData.kGap;

  List<Widget> get _children {
    if (widget.items.isEmpty) return [];
    if (widget.range.length < _gap) {
      final result = <Widget>[];
      for (var i = 0; i <= widget.range.length; i++) {
        result.add(getIndexedItem(
          index: i,
          value: widget.items[i],
          depth: widget.depth + 1,
        ));
      }
      return result;
    }
    return _gapChildren;
  }

  List<Widget> get _gapChildren {
    int currentGap = _gap;
    while (widget.range.length / currentGap > _gap) {
      currentGap *= _gap;
    }
    int divide = widget.range.length ~/ currentGap;
    int dividedLength = currentGap * divide;
    late int gapSize;
    if (dividedLength == widget.items.length) {
      gapSize = divide;
    } else {
      gapSize = divide + 1;
    }
    final result = <Widget>[];
    for (var i = 0; i < gapSize; i++) {
      int startIndex = widget.range.start + i * currentGap;
      int endIndex = widget.range.end;
      if (i != gapSize - 1) {
        result.add(
          ListTile(
            keyName: '[$i]',
            items: widget.items,
            range:
                IndexRange(start: startIndex, end: startIndex + currentGap - 1),
            expanded: widget.expanded,
            depth: widget.depth + 1,
          ),
        );
      } else {
        result.add(
          ListTile(
            keyName: '[$i]',
            items: widget.items,
            range: IndexRange(start: startIndex, end: endIndex),
            expanded: widget.expanded,
            depth: widget.depth + 1,
          ),
        );
      }
    }
    return result;
  }

  // safe call context in build
  _initExpanded(BuildContext context) {
    if (!_init) {
      _init = true;
      final jsonConfig = JsonConfig.of(context);
      _expanded = jsonConfig.style?.openAtStart ?? false;
      int depth = jsonConfig.style?.depth ?? 0;
      if (depth > 0) {
        _expanded = depth > widget.depth;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final jsonConfig = JsonConfig.of(context);
    _initExpanded(context);
    Widget result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MapListTile(
          keyName: widget.keyName,
          value: _value,
          onTap: _changeState,
          expanded: _expanded,
          showLeading: widget.items.isNotEmpty,
          // arrow: widget.arrow,
        ),
        if (_expanded)
          Padding(
            padding: jsonConfig.itemPadding ?? const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _children,
            ),
          ),
      ],
    );
    if (jsonConfig.animation ?? JsonConfigData.kUseAnimation) {
      result = AnimatedSize(
        alignment: Alignment.topCenter,
        duration:
            jsonConfig.animationDuration ?? const Duration(milliseconds: 300),
        curve: jsonConfig.animationCurve ?? Curves.ease,
        child: result,
      );
    }

    return result;
  }
}
