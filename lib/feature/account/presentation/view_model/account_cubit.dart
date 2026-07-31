import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';
import 'package:project_graduation/feature/account/domain/use_case/get_account_use_case.dart';
import 'package:project_graduation/feature/account/domain/use_case/update_account_use_case.dart';
import 'account_state.dart';

@lazySingleton
class AccountCubit extends Cubit<AccountState> {
  final GetAccountUseCase _getAccountUseCase;
  final UpdateAccountUseCase _updateAccountUseCase;
  final ImagePicker _imagePicker = ImagePicker();

  File? selectedImageFile;
  AccountEntity? currentAccount;

  AccountCubit(
    this._getAccountUseCase,
    this._updateAccountUseCase,
  ) : super(AccountInitial());

  Future<void> getProfile() async {
    emit(AccountLoading());
    final result = await _getAccountUseCase.invoke();
    if (result is Success<AccountEntity>) {
      if (result.data.name.isEmpty && result.data.email.isEmpty) {
        currentAccount = null;
        emit(AccountEmpty());
      } else {
        currentAccount = result.data;
        emit(AccountLoaded(result.data));
      }
    } else if (result is Error<AccountEntity>) {
      final errorMsg = result.messageError.toLowerCase();
      if (errorMsg.contains('not found') ||
          errorMsg.contains('no profile') ||
          errorMsg.contains('no portfolio') ||
          errorMsg.contains('empty') ||
          errorMsg.contains('not exist') ||
          errorMsg.contains('404')) {
        currentAccount = null;
        emit(AccountEmpty());
      } else {
        emit(AccountError(result.messageError));
      }
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? password,
  }) async {
    emit(AccountUpdating());

    final result = await _updateAccountUseCase.invoke(
      name: name,
      email: email,
      phone: phone,
      address: address,
      password: password,
      imageFile: selectedImageFile,
    );

    if (result is Success<void>) {
      await getProfile();
      if (state is AccountLoaded) {
        emit(AccountUpdateSuccess((state as AccountLoaded).account));
      } else if (currentAccount != null) {
        emit(AccountUpdateSuccess(currentAccount!));
      }
    } else if (result is Error<void>) {
      emit(AccountError(result.messageError));
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        selectedImageFile = File(pickedFile.path);
        if (state is AccountLoaded) {
          emit(AccountLoaded((state as AccountLoaded).account));
        } else if (currentAccount != null) {
          emit(AccountLoaded(currentAccount!));
        }
      }
    } catch (e) {
      emit(AccountError('Failed to pick image: ${e.toString()}'));
    }
  }

  void clearSelectedImage() {
    selectedImageFile = null;
  }
}
