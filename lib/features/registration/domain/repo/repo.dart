abstract class UserRegistrationRepo {
  Future<void> sendRegistrationData(
    String email,
    String login,
    String password,
    String rePassword,
  );
}
