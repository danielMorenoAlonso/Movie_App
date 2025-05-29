import 'package:cinemapedia/domain/datasources/localstorage_datasource.dart';
import 'package:cinemapedia/domain/repositores/localstorage_repository.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class LocalstorageRepositoryImpl extends LocalstorageRepository {
  final LocalstorageDatasource datasource;

  LocalstorageRepositoryImpl({required this.datasource});

  @override
  Future<bool> isFavoriteMovie(int movieId) {
    return datasource.isFavoriteMovie(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
