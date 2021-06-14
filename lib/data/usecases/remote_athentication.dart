import 'package:meta/meta.dart';

import '../../domain/usecases/usecases.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClients httpClients;
  final String url;
  RemoteAuthentication({@required this.httpClients, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    
    await httpClients.request(url: url, method: 'post', body: params.toJson());
  }
}