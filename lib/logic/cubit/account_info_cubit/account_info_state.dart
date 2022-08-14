part of 'account_info_cubit.dart';

abstract class AccountInfoState extends Equatable {
  const AccountInfoState();

  @override
  List<Object> get props => [];
}

class AccountInfoError extends AccountInfoState {
  final String error;
  const AccountInfoError({required this.error});
}

class AccountInfoLoading extends AccountInfoState {}

class AccountInfoLoaded extends AccountInfoState {
  final AccountModel accountModel;
  const AccountInfoLoaded({required this.accountModel});
}
