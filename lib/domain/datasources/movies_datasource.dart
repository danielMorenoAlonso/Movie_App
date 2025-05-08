import 'package:cinemapedia/domain/entities/movie.dart';

// Estos son los origenes de datos
abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  // Se generan los metodos para obtener nuevas peliculas
  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);
}
