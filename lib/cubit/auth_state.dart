abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignedUp extends AuthState {}

class AuthSignedIn extends AuthState {}

class AuthSignedOut extends AuthState {}

class AuthEmailNotVerified extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
