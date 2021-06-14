import 'package:meta/meta.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteAuthentication {
  final HttpClients httpClients;
  final String url;
  RemoteAuthentication({@required this.httpClients, @required this.url});

  Future<void> auth() async {
    await httpClients.request(url: url, method: 'post');
  }
}

abstract class HttpClients {
  Future<void> request({
    @required String url,
    @required String method,
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
    await sut.auth();
    //acert
    verify(httpClients.request(url: url, method: 'post'));
  });
}
