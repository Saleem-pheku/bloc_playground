// here we are building mainly three states
// loading state
// loaded state
// error state

// import 'package:bloc_playground/models/Auth_response.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

// Loading state
class AuthorizingState extends AuthState {
  AuthorizingState();

  @override
  List<Object?> get props => [];
}

// loaded state
class AuthenticatedState extends AuthState {
  AuthenticatedState();

  @override
  List<Object?> get props => [];
}

// when user is not authenticated
class UnAuthenticatedState extends AuthState {
  UnAuthenticatedState();

  @override
  List<Object?> get props => [];
}

// fasak state
class AuthFailedState extends AuthState {
  final String error;

  AuthFailedState(this.error);

  @override
  List<Object?> get props => [error];
}
