import 'dart:async';
import 'package:auth_lorby/features/authorization/domain/use_case/auth_use_case.dart';
import 'package:bloc/bloc.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final AuthorizationUseCase _authUseCase;

  AuthorizationBloc(this._authUseCase) : super(AuthorizationInitial()) {
    on<AuthorizationSubmit>(_userAuthorization);
  }

  FutureOr<void> _userAuthorization(
      AuthorizationSubmit event, Emitter<AuthorizationState> emit) async {
    try {
      await _authUseCase.call(event.email, event.password);
      emit(AuthorizationDone());
    } catch (e) {
      emit(AuthorizationFailure(error: e));
    }
  }
}
