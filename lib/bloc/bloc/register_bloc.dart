import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_state.dart';
import 'package:fresh_app_teamproj/bloc/bloc/validators.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository? _userRepository;
  RegisterBloc({required UserRepository userRepository})
      : super(RegisterState.initial()) {
    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<RegisterSubmitted>(_onRegisterSubmittedChanged);
  }

  Future<void> _onRegisterEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit,
      {String? email}) async {
    if (email != null) {
      emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
    }
  }

  Future<void> _onRegisterPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit,
      {String? password}) async {
    if (password != null) {
      emit(state.update(
          isPasswordValid: Validators.isValidPassword(event.password)));
    }
  }

  Future<UserCredential?> _onRegisterSubmittedChanged(
      RegisterSubmitted event, Emitter<RegisterState> emit,
      {String? email, String? password}) async {
    emit(RegisterState.loading());
    try {
      await _userRepository!.signUp(event.email, event.password);
      emit(RegisterState.success());
    } catch (_) {
      emit(RegisterState.failure());
    }
  }
}
