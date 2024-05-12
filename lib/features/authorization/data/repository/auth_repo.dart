import 'package:auth_lorby/features/authorization/data/data_source/remote_data_source/authorization_data_source.dart';
import 'package:auth_lorby/features/authorization/domain/repo/auth_repo.dart';

class AuthorizationRepositoryImpl implements AuthorizationRepository {
  final AuthorizationDataSource dataSource;

  AuthorizationRepositoryImpl({required this.dataSource});

  @override
  Future<void> authorizeUser(String username, String password) async {
    return await dataSource.authUser(username, password);
  }
}
