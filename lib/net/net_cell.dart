import 'package:flutter/material.dart';
import 'package:flutter_dmcb_logger/net/net_entity.dart';
import 'package:flutter_dmcb_logger/page/json_view_page.dart';
import 'package:flutter_dmcb_logger/util/helper.dart';

class NetCell extends StatefulWidget {
  final NetEntity data;
  const NetCell({Key? key, required this.data}) : super(key: key);

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
            GestureDetector(
              child: Text(
                item.url,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              onTap: () async {
                await DHelper.copyText(item.url);
                showToast('请求地址复制成功');
              },
            ),
            const Divider(),
            const Text('Header:', style: TextStyle(fontSize: 14, color: Colors.red)),
            GestureDetector(
              child: Text(
                item.headers,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              onTap: () async {
                await DHelper.copyText(item.headers);
                showToast('请求头参数复制成功');
              },
            ),
            const Divider(),
            const Text('Parameters:', style: TextStyle(fontSize: 14, color: Colors.blue)),
            GestureDetector(
              child: Text(
                item.parameters,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              onTap: () async {
                await DHelper.copyText(item.parameters);
                showToast('请求参数复制成功');
              },
            ),
            const Divider(),
            const Text('\nResponseBody:', style: TextStyle(fontSize: 14, color: Colors.pink)),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return DJsonViewPage(title: item.api, jsonString: item.responseBody);
                  }));
                },
                child: const Text('查看详情')),
            // SelectableText(
            //   item.responseBody,
            //   style: const TextStyle(fontSize: 14, color: Colors.black),
            //   toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
            // ),
          ],
        )
      ],
    );
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

  void showToast(String title) {
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
