import 'package:meta/meta.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:myapp/domain/usecases/authentication.dart';

class RemoteAuthentication {
  final HttpClients httpClients;
  final String url;
  RemoteAuthentication({@required this.httpClients, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = {'email': params.email, 'password': params.secret};
    await httpClients.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClients {
  Future<void> request({
    @required String url,
    @required String method,
    Map body,
  });
}

class HttpClientsSpy extends Mock implements HttpClients {}

void main() {
  RemoteAuthentication sut;
  HttpClientsSpy httpClients;
  String url;
  setUp(() {
    //Arange
    httpClients = HttpClientsSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClients: httpClients, url: url);
  });
  test('Should call HttpClient with correct values', () async {
    //act
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
    await sut.auth(params);
    //acert
    verify(httpClients.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });
}
