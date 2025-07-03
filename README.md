## 已不在更新，请使用[flutter_base_logger](https://github.com/zenganiu/flutter_base_logger)

# flutter_dmcb_logger
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/zenganiu/flutter_dmcb_logger)
## **Flutter日志库**
！[console输出折叠](./doc/example_1.png)
！[app-log记录](./doc/example_2.png)
！[app-net记录](./doc/example_3.png)

## 特性
* IDEA使用`Grep Console`插件支持内容折叠。
* App支持查看日志记录。

## 安装
在 `pubspec.yaml` 中添加
```yaml
dependencies:
  flutter_dmcb_logger: ^0.0.1
```

## IDEA使用`Grep Console`插件配置
在`Folding`配置中添加`.*Data:.*`、`.*ResponseBody:.*`、`.*Parameters:.*`、`.*Header:.*`表达式,如图所示
<br>
！[console输出折叠](./doc/console_fold.png)


## 使用
```dart

// log
DLogger.info('info123456', title: 'info');
DLogger.debug('debug654', title: 'debug');
DLogger.warn('warn963', title: 'warn');
DLogger.error('error741', title: 'error');

// 接口
DLogger.net(
api: 'http://app-gw-dev.dm-cube.com/app-gw/config/getCountDownConfig',
url: 'http://app-gw-dev.dm-cube.com/app-gw/config/getCountDownConfig',
method: 'POST',
headers: {
"content-type": "application/json;charset=utf-8",
"X-DEVICE-ID": "",
"X-APP-VERSION": "3.7.10",
"X-LOGIN-TYPE": "app",
"X-DEVICE-TYPE": "2",
"X-USER-AGENT":
"Mozilla/5.0 (iPhone; CPU iPhone OS 13_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148",
"X-LONGITUDE": 113.31634307077927,
"X-LATITUDE": 23.123067240730254,
"X-CITY": "5bm/5bee5biC",
"X-CHANNEL-CODE": "AppStore"
},
parameters: '{}',
responseBody: {
"code": "00000",
"message": "成功",
"payload": {"enable": true, "countDown": 5, "deadline": 18000000}
},
);
                    
```
