import 'package:dio/dio.dart';
import 'package:stadium/models/user.dart';
import 'package:stadium/utils/constants.dart';

class AutenticacaoRepository {
  final Dio dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
  ));

  Future getUsers() async {
    try {
      final response = await dio.get('/users/.json');
      List<Users> users = [];
      response.data.forEach((key, value) {
        users.add(Users.fromJson(value));
      });
      return users;
    } catch (e) {
      // Handle error
    }
  }

  Future postUser(Users user) async {
    try {
      final response = await dio.post('/users/.json', data: user.toJson());
      return response.data;
    } catch (e) {
      // Handle error
    }
  }
}
