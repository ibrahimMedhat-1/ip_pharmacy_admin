part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class ChangeObscure extends AuthState {}

class ClearAllTextFormFields extends AuthState {}

class CreateUserLoading extends AuthState {}

class CreateUserSuccessfully extends AuthState {}

class CreateUserError extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccessfully extends AuthState {}

class LoginError extends AuthState {}

class ChangeCheckBoxValue extends AuthState {}
