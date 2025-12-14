import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_sources/local_database.dart';
import '../repositories/local_storage_repository_impl.dart';
import '../repositories/preferences_repository_impl.dart';
import '../repositories/secure_storage_repository_impl.dart';
import '../../domain/repositories/local_storage_repository.dart';
import '../../domain/repositories/preferences_repository.dart';
import '../../domain/repositories/secure_storage_repository.dart';


final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return LocalDatabase();
});


final localStorageRepositoryProvider = Provider<LocalStorageRepository>((ref) {
  final database = ref.watch(localDatabaseProvider);
  return LocalStorageRepositoryImpl(database);
});

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepositoryImpl();
});

final secureStorageRepositoryProvider = Provider<SecureStorageRepository>((ref) {
  return SecureStorageRepositoryImpl();
});

