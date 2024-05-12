import 'package:auth_lorby/features/authorization/domain/repo/auth_repo.dart';

class AuthorizationUseCase {
  final AuthorizationRepository repository;

  AuthorizationUseCase({required this.repository});

  Future<void> call(String username, String password) async {
    return repository.authorizeUser(username, password);
  }
}
