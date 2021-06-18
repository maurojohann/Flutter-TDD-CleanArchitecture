import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({Key key, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              return showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Aguarde...', textAlign: TextAlign.center),
                        ],
                      )
                    ],
                  );
                },
              );
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });
          presenter.mainErrorStream.listen((error) {
            if (error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[900],
                  content: Text(error, textAlign: TextAlign.center),
                ),
              );
            }
          });
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                Text(
                  'Login'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                      child: Column(
                    children: [
                      StreamBuilder<String>(
                          stream: presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: presenter.validateEmail,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                        child: StreamBuilder<String>(
                            stream: presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Senha',
                                    icon: Icon(
                                      Icons.lock,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data),
                                obscureText: true,
                                onChanged: presenter.validatePassword,
                              );
                            }),
                      ),
                      StreamBuilder<bool>(
                          stream: presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                                onPressed: snapshot.data == true
                                    ? presenter.auth
                                    : null,
                                child: Text('Entrar'));
                          }),
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.person),
                          label: Text('Criar Conta'))
                    ],
                  )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
