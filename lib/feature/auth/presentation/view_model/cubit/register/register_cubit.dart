import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_requiest_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/use_case/register_use_case.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  Future<void> intent(RegisterIntent intent) async {
    switch (intent) {
      case RegisterIntentRegister():
        await _register(intent.request);
    }
  }

  Future<void> _register(RegisterRequestEntity request) async {
    emit(RegisterLoading());
    final result = await _registerUseCase.invoke(request);
    switch (result) {
      case Success<String>():
        emit(RegisterSuccess());
      case Error<String>():
        emit(RegisterError(result.messageError));
    }
  }
}

sealed class RegisterIntent {}

class RegisterIntentRegister extends RegisterIntent {
  final RegisterRequestEntity request;
  RegisterIntentRegister(this.request);
}

typedef RegisterIntentRequest = RegisterIntentRegister;