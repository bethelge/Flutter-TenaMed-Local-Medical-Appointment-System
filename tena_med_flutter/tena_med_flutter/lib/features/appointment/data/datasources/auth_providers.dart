import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api.dart';

import '../repository_impl/auth_repository_impl.dart'; // import the interface

// 1. Provide the AuthApi
final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(baseUrl: 'http://10.0.2.2:5000');
});

// 2. Provide the AuthRepository (interface), implemented by AuthRepositoryImpl
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.watch(authApiProvider);
  return AuthRepositoryImpl(authApi: api);
});
