import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmcb_logger/page/logger_list_page.dart';

var _hasShowLogPage = false;

class DOverlayDebugView extends StatefulWidget {
  static var isShow = false;
  final Offset offset;
  final double height;
  final OverlayEntry? overlayEntry;

  const DOverlayDebugView({
    super.key,
    this.offset = const Offset(0, 300),
    this.height = 50,
    this.overlayEntry,
  });

  static show({required BuildContext context}) {
    if (DOverlayDebugView.isShow || kReleaseMode) {
      return;
    }
    var overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return const DOverlayDebugView();
      },
    );

    ///插入全局悬浮控件
    overlayState.insert(overlayEntry);
    DOverlayDebugView.isShow = true;
  }

  @override
  State<DOverlayDebugView> createState() => _DOverlayDebugViewState();
}

class _DOverlayDebugViewState extends State<DOverlayDebugView> {
  late Offset _offset;
  late double _height;
  late OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _offset = widget.offset;
    _height = widget.height;
    _overlayEntry = widget.overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: _offset.dx,
        top: _offset.dy,
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onPanDown: (details) {
            _offset = details.globalPosition - Offset(_height / 2, _height / 2);
            setState(() {});
            _overlayEntry?.markNeedsBuild();
          },
          onPanUpdate: (DragUpdateDetails details) {
            ///根据触摸修改悬浮控件偏移
            _offset = _offset + details.delta;
            setState(() {});
            _overlayEntry?.markNeedsBuild();
          },
          onPanEnd: (details) {
            double dx = 0;
            double dy = _offset.dy;

            final media = MediaQuery.of(context);
            final size = media.size;
            if (_offset.dx >= size.width / 2 - widget.height / 2) {
              dx = size.width - widget.height;
            }
            if (_offset.dy <= media.padding.top) {
              dy = media.padding.top;
            }
            if (_offset.dy >= size.height - 88) {
              dy = size.height - 88;
            }

            _offset = Offset(dx, dy);
            setState(() {});
            _overlayEntry?.markNeedsBuild();
          },
          onLongPress: _longPress,
          onTap: () {},
          child: Opacity(
            opacity: 0.9,
            child: Container(
              height: _height,
              width: _height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
                borderRadius: BorderRadius.all(
                  Radius.circular(_height / 2),
                ),
              ),
              child: TextButton(
                child: const Icon(
                  Icons.bug_report,
                  color: Colors.red,
                ),
                onPressed: () async {
                  if (_hasShowLogPage) return;
                  _hasShowLogPage = true;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const DLoggerListPage();
                      },
                    ),
                  );
                  _hasShowLogPage = false;
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  _longPress() {}
}
