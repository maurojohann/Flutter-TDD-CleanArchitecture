import 'package:meta/meta.dart';

abstract class HttpClients {
  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  });
}