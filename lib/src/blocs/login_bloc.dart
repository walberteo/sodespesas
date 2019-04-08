import 'dart:async';
//Simport '../utils/strings.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();
  final _user = BehaviorSubject<FirebaseUser>();

  Observable<String> get email => _email.stream.transform(_validateEmail);

  Observable<String> get password =>
      _password.stream.transform(_validatePassword);

  Observable<bool> get signInStatus => _isSignedIn.stream;

  String get emailAddress => _email.value;

  FirebaseUser get user => _user.value;

  // Change data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(bool) get showProgressBar => _isSignedIn.sink.add;

  Function(FirebaseUser) get changeUser => _user.sink.add;

  final _validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Informe um e-mail válido');
      //sink.addError(StringConstant.emailValidateMessage);
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 6) {
      sink.add(password);
    } else {
      sink.addError('A senha deve possuir no minímo 7 caractes');
      //sink.addError(StringConstant.passwordValidateMessage);
    }
  });

  Future<FirebaseUser> submit() {
    return _repository
        .authenticateUser(_email.value, _password.value)
        .catchError((e) {
      if (e.code == 'ERROR_INVALID_EMAIL') {
        // - If the [email] address is malformed.
        _email.sink.addError('E-mail inválido');
      } else if (e.code == 'ERROR_WRONG_PASSWORD') {
        //If the [password] is wrong.
        _password.sink.addError('Senha incorreda');
      } else if (e.code == 'ERROR_USER_NOT_FOUND') {
        //If there is no user corresponding to the given [email] address, or if the user has been deleted.
        return registerUser();
      } else if (e.code == 'ERROR_USER_DISABLED') {
        //If the user has been disabled (for example, in the Firebase console)
        _email.sink.addError('Usuário desativo');
      } else if (e.code == 'ERROR_TOO_MANY_REQUESTS') {
        //If there was too many attempts to sign in as this user.
        _email.sink.addError('Muitas requisições realizada para esse usuário');
      } else {
        _email.sink.addError('Erro ao realizar requisição');
      }
    });
  }

  Future<FirebaseUser> registerUser() {
    return _repository
        .registerUser(_email.value, _password.value)
        .catchError((onError) => print(onError));
  }

  Future<void> logoutUser() {
    return _repository.logoutUser().then((e) => changeUser(null));
  }

  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
    await _user.drain();
    _user.close();
  }

  bool validateFields() {
    if (_email.value != null &&
        _email.value.isNotEmpty &&
        _password.value != null &&
        _password.value.isNotEmpty &&
        _email.value.contains('@') &&
        _password.value.length > 6) {
      return true;
    } else {
      return false;
    }
  }
}
