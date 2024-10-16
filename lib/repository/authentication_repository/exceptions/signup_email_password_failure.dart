class SignupEmailPasswordFailure {
  final String message;

  const SignupEmailPasswordFailure([this.message = "An Unknown error occured"]);

  factory SignupEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignupEmailPasswordFailure('Please enter a stronger password.');
      case 'invalid-email':
        return SignupEmailPasswordFailure('Please enter a stronger password.');
      case 'email-already-in-use':
        return SignupEmailPasswordFailure('Please enter a stronger password.');
      case 'operation-not-allowed':
        return SignupEmailPasswordFailure('Please enter a stronger password.');
      case 'user-disabled':
        return SignupEmailPasswordFailure('Please enter a stronger password.');
      default:
        return const SignupEmailPasswordFailure();
    }
  }
}
