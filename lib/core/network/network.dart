import 'package:dio/dio.dart';
import 'package:pokemon/core/resources/constants.dart';

class Network {
  static final Network _network = Network._internal();
  factory Network() => _network;

  Network._internal();
  final dio = Dio();

  Dio request() {
    dio.options.baseUrl = baseUri;

    /// Add an interceptor to log all requests
    return dio;
  }
}
