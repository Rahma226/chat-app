part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegiterLoading extends RegisterState {}

final class RegiterSuccess extends RegisterState {}

final class RegiterFailure extends RegisterState {
  String errMessage;
  RegiterFailure({required this.errMessage});
}
