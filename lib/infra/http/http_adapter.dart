import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:myapp/data/http/http.dart';

class HttpAdapter implements HttpClients {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request(
      {@required String url, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response =
        await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    return _handdleResponse(response);
  }

  Map _handdleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
