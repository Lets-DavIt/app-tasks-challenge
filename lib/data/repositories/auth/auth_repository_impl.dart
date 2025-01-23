import 'dart:async';

import 'package:app_tasks_challenge/data/repositories/auth/auth_repository.dart';
import 'package:app_tasks_challenge/domain/dtos/credentials.dart';
import 'package:app_tasks_challenge/domain/entities/user_entity.dart';
import 'package:app_tasks_challenge/domain/validators/credentials_validators.dart';
import 'package:app_tasks_challenge/service/auth/auth_client_http.dart';
import 'package:app_tasks_challenge/service/auth/auth_local_storage.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._localStorage, this._clientHttp);

  final AuthClientHttp _clientHttp;
  final AuthLocalStorage _localStorage;
  final _streamController = StreamController<User>.broadcast();

  @override
  Stream<User> userObserver() {
    return _streamController.stream;
  }

  @override
  AsyncResult<LoggedUser> login(Credentials credentials) {
    final validator = CredentialsValidators();

    return validator
        .validateResult(credentials)
        .flatMap(_clientHttp.login)
        .flatMap(_localStorage.saveUser)
        .onSuccess(_streamController.add);
  }

  @override
  AsyncResult<Unit> logout() {
    return _localStorage.removeUser().onSuccess((_) {
      _streamController.add(const NotLoggedUser());
    });
  }

  @override
  AsyncResult<LoggedUser> getUser() {
    return _localStorage.getUser();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
