abstract class AuthorizationRepository {
  Future<void> authorizeUser(String username, String password);
}
