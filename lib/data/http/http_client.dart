import 'package:meta/meta.dart';

abstract class HttpClients {
  Future<void> request({
    @required String url,
    @required String method,
    Map body,
  });
}