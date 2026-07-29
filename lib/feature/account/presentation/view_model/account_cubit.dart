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

  // ─── Get Profile ──────────────────────────────────────────────────────────

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

  // ─── Update Profile ───────────────────────────────────────────────────────

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
      selectedImageFile = null; // clear local image on success
      emit(AccountUpdateSuccess(result.data));
    } else if (result is Error<AccountEntity>) {
      // Stay in error state — the UI listener will show a SnackBar and keep
      // the user on the Edit screen so they can retry.
      emit(AccountError(result.messageError));
    }
  }

  // ─── Image Picker ─────────────────────────────────────────────────────────

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        selectedImageFile = File(pickedFile.path);
        // Re-emit the current loaded state so the avatar preview rebuilds.
        if (currentAccount != null) {
          emit(AccountLoaded(currentAccount!));
        }
      }
    } catch (e) {
      emit(AccountError('Failed to pick image: ${e.toString()}'));
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  void clearSelectedImage() {
    selectedImageFile = null;
  }
}
