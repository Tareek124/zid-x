part of 'google_sign_in_cubit.dart';

@immutable
abstract class GoogleSignInState {}

class GoogleSignInInitial extends GoogleSignInState {}

class GoogleSignInLoading extends GoogleSignInState {}

class GoogleSignINError extends GoogleSignInState {
  final String error;
  GoogleSignINError({required this.error});
}

class GoogleSignInSuccess extends GoogleSignInState {}
