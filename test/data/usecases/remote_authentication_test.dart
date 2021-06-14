import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:myapp/domain/helpers/helpers.dart';
import 'package:myapp/domain/usecases/usecases.dart';

import 'package:myapp/data/http/http.dart';
import 'package:myapp/data/usecases/usecases.dart';

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
  test(
    'Should call HttpClient with correct values',
    () async {
      //act
      final params = AuthenticationParams(
          email: faker.internet.email(), secret: faker.internet.password());
      await sut.auth(params);
      //acert
      verify(httpClients.request(
          url: url,
          method: 'post',
          body: {'email': params.email, 'password': params.secret}));
    },
  );
  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClients.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);

    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
