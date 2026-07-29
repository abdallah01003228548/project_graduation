import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';
import 'package:project_graduation/feature/account/domain/use_case/get_account_use_case.dart';
import 'package:project_graduation/feature/account/domain/use_case/update_account_use_case.dart';
import 'account_state.dart';

@injectable
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
      currentAccount = result.data;
      emit(AccountLoaded(result.data));
    } else if (result is Error<AccountEntity>) {
      emit(AccountError(result.messageError));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? password,
  }) async {
    emit(AccountUpdating());
    
    final result = await _updateAccountUseCase.invoke(
      name: name,
      email: email,
      password: password,
      imageFile: selectedImageFile,
    );

    if (result is Success<AccountEntity>) {
      currentAccount = result.data;
      selectedImageFile = null; // Clear local selected image on success
      emit(AccountUpdateSuccess(result.data));
    } else if (result is Error<AccountEntity>) {
      emit(AccountError(result.messageError));
      // Re-emit loaded so the form fields don't get stuck in error or blank state
      if (currentAccount != null) {
        emit(AccountLoaded(currentAccount!));
      }
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
        // If we are currently in Loaded state, re-emit loaded to refresh preview
        if (currentAccount != null) {
          emit(AccountLoaded(currentAccount!));
        }
      }
    } catch (e) {
      emit(AccountError('Failed to pick image: ${e.toString()}'));
      if (currentAccount != null) {
        emit(AccountLoaded(currentAccount!));
      }
    }
  }

  void clearSelectedImage() {
    selectedImageFile = null;
  }
}
