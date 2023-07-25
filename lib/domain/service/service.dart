import 'package:dio/dio.dart';

String? pred;

class Service {
  Future<void> getHttp() async {
    final response = await Dio().get('https://www.eightballapi.com/api');
    pred = response.data['reading'];
  }
}

final data = Service();
