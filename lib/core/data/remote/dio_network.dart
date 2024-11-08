import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioNetworkProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: 'https://howiyapress.com/wp-json/wp/v2',
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );

  final dio = Dio(options);

  return dio;
});
