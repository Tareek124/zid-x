part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountError extends AccountState {
  final String error;
  const AccountError({required this.error});
}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {}
