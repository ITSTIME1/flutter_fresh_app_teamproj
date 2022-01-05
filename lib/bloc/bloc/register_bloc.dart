import 'package:bloc/bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_state.dart';
import 'package:fresh_app_teamproj/bloc/bloc/validators.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

// [Register Bloc]

// RegisterEvent & RegisterState 값을 연결하는 공간 입니다.
// RegisterEvent 값이 실행되었을때 상태가 어떻게 변하는지 핸들링합니다.
// ex) _onRegisterEmailChanged 의 email 값을 Validators를 먼저 거쳐서 유효성 검사를 받은다음 state.update 해줍니다.
// 그렇다면 isValidEmail(email) 값은 update로 이어져 적용이됩니다.

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository? _userRepository;
  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial()) {
    // [Bloc 8.0.0]
    // Bloc 버전의 업그레이드로 인해 기존의 StreamBuilder 값을 사용하지 못하게 되었습니다.
    // Bloc Cubit을 사용해서 구현하면 편하겠지만
    // 이번 앱에서는 상태관리중 가장 역사가 깊은 Bloc Pattern을 사용하기로 결정하였으니, 그나마 사용하기 쉬운 Cubit 을 사용하지 않고
    // 전체 코드 다 Bloc로만 로직을 구현하였습니다.

    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<RegisterSubmitted>(_onRegisterSubmittedChanged);
  }

  Future<void> _onRegisterEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit,
      {String? email}) async {
    if (email != null) {
      return emit(state.update(isEmailValid: Validators.isValidEmail(email)));
    }
  }

  Future<void> _onRegisterPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit,
      {String? password}) async {
    if (password != null) {
      return emit(
          state.update(isPasswordValid: Validators.isValidPassword(password)));
    }
  }

  Future<void> _onRegisterSubmittedChanged(
      RegisterSubmitted event, Emitter<RegisterState> emit,
      {String? email, String? password}) async {
    emit(RegisterState.loading());
    try {
      await _userRepository!
          .signUp(email: event.email, password: event.password);
      emit(RegisterState.success());
    } catch (_) {
      emit(RegisterState.failure());
    }
  }
}
