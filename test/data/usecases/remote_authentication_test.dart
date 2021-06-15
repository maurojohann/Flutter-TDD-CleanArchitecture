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
  AuthenticationParams params;
  setUp(() {
    httpClients = HttpClientsSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClients: httpClients, url: url);
    params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
  });
  test(
    'Should call HttpClient with correct values',
    () async {
      when(httpClients.request(
              url: anyNamed('url'),
              method: anyNamed('method'),
              body: anyNamed('body')))
          .thenAnswer((_) async => {
                'accessToken': faker.guid.guid(),
                'name': faker.person.name(),
              });
      await sut.auth(params);

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

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    when(httpClients.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    when(httpClients.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw InvalidCredentialsError if HttpClient returns 401',
      () async {
    when(httpClients.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });
  test('Should return an Account if HttpClient returns 200', () async {
    final accessToken = faker.guid.guid();
    when(httpClients.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenAnswer((_) async => {
              'accessToken': accessToken,
              'name': faker.person.name(),
            });

    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });
  test(
      'Should throw UnexpectedError  if HttpClient returns 200 with invalid data',
      () async {
    when(httpClients.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenAnswer((_) async => {
              'invalid_key': 'invalid_value ',
            });

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
