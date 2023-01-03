part of 'auth_bloc.dart';

abstract class AuthState {}

class InitializingAuthState extends AuthState {}

class GoogleAuthentication extends AuthState {}

class GoogleAuthenticationComplete extends AuthState {
  final String name;
  final String emailId;
  final String url;
  GoogleAuthenticationComplete({required this.name, required this.emailId, required this.url});
}

class GoogleAuthenticationFailed extends AuthState {
  final Error error;
  GoogleAuthenticationFailed({required this.error});
}
