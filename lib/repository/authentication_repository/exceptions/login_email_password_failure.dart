class LoginEmailPasswordFailure {
  final String message;

  const LoginEmailPasswordFailure([this.message = "An Unknown error occured"]);

  factory LoginEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return LoginEmailPasswordFailure('Please enter a valid email.');
      case 'wrong-password':
        return LoginEmailPasswordFailure('Please enter a valid password.');
      default:
        return const LoginEmailPasswordFailure();
    }
  }
}
