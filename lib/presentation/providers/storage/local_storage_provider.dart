import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasource/isar_localstorage_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/localstorage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalstorageRepositoryImpl(datasource: IsarLocalstorageDatasource());
});
