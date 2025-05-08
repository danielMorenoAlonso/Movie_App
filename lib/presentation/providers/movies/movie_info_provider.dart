import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final getMovie = ref.watch(movieRepositoryProvider);
      return MovieMapNotifier(getMovie: getMovie.getMovieById);
    });

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};

    /* Se espera devolver un mapa de tipo
    {
      '554302'=>Movie(),
      '554303'=>Movie(),
      '554304'=>Movie(),
      '554305'=>Movie(),
    }

    */
  }
}
