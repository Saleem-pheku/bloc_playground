import 'package:bloc_playground/bloc/auth_bloc/auth_event.dart';
import 'package:bloc_playground/bloc/auth_bloc/auth_state.dart';
import 'package:bloc_playground/models/auth/login_response.dart';
import 'package:bloc_playground/services/auth/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authServices;
  LoginBloc({required this.authServices}) : super(AuthorizingState()) {
    on<AppStartedEvent>(checkAuth);
    on<LoginAttemptEvent>(getOtp);
    on<LogInEvent>(verifyOtp);
  }

  Future<void> checkAuth(
      AppStartedEvent event, Emitter<AuthState> emit) async {}

  Future<void> getOtp(LoginAttemptEvent event, Emitter<AuthState> emit) async {
    emit(AuthorizingState());
    try {
      await authServices.getOtp(event.phoneNumber);
      emit(AuthorizingState());
    } catch (e) {
      emit(AuthFailedState(e.toString()));
    }
  }

  Future<void> verifyOtp(LogInEvent event, Emitter<AuthState> emit) async {
    emit(AuthorizingState());
    try {
      await authServices.loginWithMobile(event.phoneNumber, event.otp);
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthFailedState(e.toString()));
    }
  }
}
