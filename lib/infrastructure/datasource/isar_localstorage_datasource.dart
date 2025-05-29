import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cinemapedia/domain/datasources/localstorage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class IsarLocalstorageDatasource extends LocalstorageDatasource {
  late Future<Isar> db;

  IsarLocalstorageDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;

    return await isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      // Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // Insertar

    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
