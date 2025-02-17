import 'package:flutter/material.dart';
import 'package:flutter_dmcb_logger/net/net_entity.dart';
import 'package:flutter_dmcb_logger/page/json_view_page.dart';
import 'package:flutter_dmcb_logger/util/helper.dart';

class NetCell extends StatefulWidget {
  final NetEntity data;
  const NetCell({super.key, required this.data});

  @override
  State<NetCell> createState() => _NetCellState();
}

class _NetCellState extends State<NetCell> {
  NetEntity get item => widget.data;
  @override
  Widget build(BuildContext context) {
    final color = _getColor(item.statusCode);
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(top: 0, right: 8, left: 8),
      tilePadding: const EdgeInsets.only(top: 4, right: 8, left: 8),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '[${item.method}]',
              style: const TextStyle(fontSize: 14, color: Colors.blue),
            ),
            TextSpan(
              text: '[${item.statusCode.toString()}]',
              style: TextStyle(fontSize: 14, color: color),
            ),
            TextSpan(
              text: item.startTime.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ],
        ),
      ),
      subtitle: Text(
        item.api.toString(),
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      expandedAlignment: Alignment.centerLeft,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const Text('Url:', style: TextStyle(fontSize: 14, color: Colors.purple)),
            _CopyText(
              content: item.url,
              title: '请求地址',
              onTapCopy: () {
                showToast('请求地址复制成功', context);
              },
            ),
            const SizedBox(height: 12),
            const Text('Header:', style: TextStyle(fontSize: 14, color: Colors.red)),
            _CopyTextAndButton(
              title: '请求头参数',
              content: item.headers,
              onTapCopy: () {
                showToast('请求头参数复制成功', context);
              },
              onTapButton: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return DJsonViewPage(title: item.api, jsonString: item.headers);
                }));
              },
            ),
            const SizedBox(height: 12),
            const Text('Parameters:', style: TextStyle(fontSize: 14, color: Colors.blue)),
            _CopyTextAndButton(
              title: '请求参数',
              content: item.parameters,
              onTapCopy: () {
                showToast('请求参数复制成功', context);
              },
              onTapButton: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return DJsonViewPage(title: item.api, jsonString: item.parameters);
                }));
              },
            ),
            const SizedBox(height: 12),
            const Text('\nResponseBody:', style: TextStyle(fontSize: 14, color: Colors.pink)),
            _CopyTextAndButton(
              title: '响应结果',
              content: item.responseBody,
              onTapCopy: () {
                showToast('响应结果复制成功', context);
              },
              onTapButton: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return DJsonViewPage(title: item.api, jsonString: item.responseBody);
                }));
              },
            ),
            const SizedBox(height: 12),
          ],
        )
      ],
    );
  }

  void showToast(String title, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

Color _getColor(int status) {
  if (status == 200 || status == 0) {
    return Colors.green;
  } else if (status < 200) {
    return Colors.blue;
  } else {
    return Colors.red;
  }
}

class _CopyTextAndButton extends StatelessWidget {
  final String content;
  final String title;
  final void Function()? onTapCopy;
  final void Function()? onTapButton;
  const _CopyTextAndButton({
    required this.content,
    required this.title,
    this.onTapCopy,
    this.onTapButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              await DHelper.copyText(content);
              onTapCopy?.call();
            },
            child: Text(
              content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            onTapButton?.call();
          },
          child: const Text('更多'),
        ),
      ],
    );
  }
}

class _CopyText extends StatelessWidget {
  final String content;
  final String title;
  final void Function()? onTapCopy;
  const _CopyText({
    required this.content,
    required this.title,
    this.onTapCopy,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        content,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      onTap: () async {
        await DHelper.copyText(content);
        onTapCopy?.call();
      },
    );
  }
}
