import 'package:dio/dio.dart';

abstract class AuthorizationDataSource {
  Future<void> authUser(String email, String password);
}

class AuthorizationDataSourceImpl extends AuthorizationDataSource {
  final Dio dio;

  AuthorizationDataSourceImpl({required this.dio});

  @override
  Future<void> authUser(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    const url = 'http://165.22.72.60:8080/api/user/login';
    final response = await dio.post(url, data: data);
  }
}
