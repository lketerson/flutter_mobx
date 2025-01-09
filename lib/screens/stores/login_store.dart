import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase() {}

  @observable
  String email = "";

  @observable
  bool isPasswordObscured = true;

  @observable
  String password = "";

  @observable
  bool isLoading = false;

  @observable
  bool loggedIn = false;

  @computed
  bool get _isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get _isPasswordValid => password.length > 6;

  @computed
  bool get isFormValid => _isEmailValid && _isPasswordValid;

  @computed
  Function? get loginPressed =>
      (_isEmailValid && _isPasswordValid && !isLoading) ? login : null;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void tooglePasswordVisibility() => isPasswordObscured = !isPasswordObscured;

  @action
  Future<void> login() async {
    isLoading = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    loggedIn = true;
  }
}
