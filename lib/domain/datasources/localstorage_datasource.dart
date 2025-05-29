import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalstorageDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isFavoriteMovie(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});
}
