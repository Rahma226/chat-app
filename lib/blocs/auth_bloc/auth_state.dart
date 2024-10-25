part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  String errMessage;
  LoginFailure({required this.errMessage});
}

final class RegisterInitial extends AuthState {}

final class RegiterLoading extends AuthState {}

final class RegiterSuccess extends AuthState {}

final class RegiterFailure extends AuthState {
  String errMessage;
  RegiterFailure({required this.errMessage});
}
