import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_config.dart';
import '../network/dio_client.dart';
import '../utils/logger.dart';

/// Provides HTTP client (Dio instance)
final dioProvider = Provider<Dio>((ref) {
  return DioClient.create();
});

/// Base URL provider
final baseUrlProvider = Provider<String>((ref) {
  return AppConfig.apiBaseUrl;
});

/// Logger provider
final loggerProvider = Provider((ref) => logger);
