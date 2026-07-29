import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/domain/entity/login_response_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/use_case/login_use_case.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  final LoginUseCase _loginUseCase;

  Future<void> intent(LoginIntent intent) async {
    switch (intent) {
      case LoginIntentLogin():
        _login(email: intent.email, password: intent.password);
    }
  }

  Future<void> _login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await _loginUseCase.invoke(email: email, password: password);
    switch (result) {
      case Success<LoginResponseEntity>():
        emit(LoginSuccess(result.data));
      case Error<LoginResponseEntity>():
        emit(LoginError(result.messageError));
    }
  }
}

sealed class LoginIntent {}

class LoginIntentLogin extends LoginIntent {
  final String email;
  final String password;
  LoginIntentLogin({required this.email, required this.password});
}
