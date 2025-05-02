import 'package:cinemapedia/domain/entities/movie.dart';

// Estos mandan a llamar el datasource
abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
