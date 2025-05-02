import 'package:cinemapedia/domain/entities/movie.dart';

// Estos son los origenes de datos
abstract class MovieDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
