import 'package:despesas_androidx/src/blocs/login_bloc_provider.dart';
import 'package:despesas_androidx/src/utils/Route.dart';
import 'package:despesas_androidx/src/utils/Theme.dart' as theme;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode senhaFocus = FocusNode();

  LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _makeButtonSocial(String title) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: theme.baseTextStyle.copyWith(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: double.infinity,
        child: Material(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/CitySky.jpg',
                width: double.infinity,
              ),
              Positioned(
                top: 210,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      emailField(),
                      passwordField(),
                      button(context),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Esqueceu a sua senha?',
                          style: theme.baseTextStyle.copyWith(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _makeButtonSocial('G'),
                            SizedBox(
                              width: 50,
                            ),
                            _makeButtonSocial('f')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 32, bottom: 15),
      child: StreamBuilder(
          stream: _bloc.password,
          builder: (context, snapshot) {
            return TextField(
              onChanged: _bloc.changePassword,
              keyboardType: TextInputType.text,
              controller: senhaController,
              focusNode: senhaFocus,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Senha',
                errorText: snapshot.error,
              ),
              //onSubmitted: entrar(),
            );
          }),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 32),
      child: StreamBuilder(
          stream: _bloc.email,
          builder: (context, snapshot) {
            return TextField(
              onChanged: _bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              focusNode: emailFocus,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(senhaFocus);
              },
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'E-mail',
                errorText: snapshot.error,
              ),
            );
          }),
    );
  }

  Widget submitButton() {
    return StreamBuilder(
        stream: _bloc.signInStatus,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return button(context);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget button(context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "Login",
          style: theme.baseTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (_bloc.validateFields()) {
            authenticateUser();
          } else {
            showErrorMessage(context);
          }
        },
      ),
    );
  }

  void authenticateUser() {
    _bloc.showProgressBar(true);
    _bloc.submit().then((value) {
      if (value == null) {
        //New User
        _bloc.registerUser().then((value) {
          _bloc.changeUser(value);
        });
      } else {
        _bloc.changeUser(value);
      }
    });
  }

  void showErrorMessage(context) {
    final snackbar = SnackBar(
        content: Text('Por favor corrija todos os erros'),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
