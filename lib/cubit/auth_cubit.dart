import 'package:bloc/bloc.dart';
import 'package:fb2/cubit/auth_state.dart';
import 'package:fb2/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  User? get currentUser => _authRepository.currentUser;

  void signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      emit(AuthLoading());
      await _authRepository.signUp(
          email: email, password: password, name: name);
      await _authRepository.sendEmailVerification();
      emit(AuthSignedUp());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      await _authRepository.signIn(email: email, password: password);
      emit(AuthSignedIn());
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'ERROR_EMAIL_NOT_VERIFIED') {
        emit(AuthError('Please verify your email to sign in'));
      } else {
        emit(AuthError(e.toString()));
      }
    }
  }

  void signOut() async {
    try {
      await _authRepository.signOut();
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void checkAuthStatus() {
    if (_authRepository.currentUser != null) {
      emit(AuthSignedIn());
    } else {
      emit(AuthSignedOut());
    }
  }
}
