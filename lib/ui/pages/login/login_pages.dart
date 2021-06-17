import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({Key key, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: presenter.validateEmail,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(
                            Icons.lock,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      obscureText: true,
                      onChanged: presenter.validatePassword,
                    ),
                  ),
                  ElevatedButton(onPressed: null, child: Text('Entrar')),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar Conta'))
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
