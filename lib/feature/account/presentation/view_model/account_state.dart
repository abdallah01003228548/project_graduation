import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';

sealed class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final AccountEntity account;
  AccountLoaded(this.account);
}

class AccountEmpty extends AccountState {}

class AccountUpdating extends AccountState {}

class AccountUpdateSuccess extends AccountState {
  final AccountEntity account;
  AccountUpdateSuccess(this.account);
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}
