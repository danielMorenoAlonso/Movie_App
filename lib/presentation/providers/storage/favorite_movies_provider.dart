import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositores/localstorage_repository.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMovieNotifier, Map<int, Movie>>((ref) {
      final localStorageRepository = ref.watch(localStorageRepositoryProvider);
      return StorageMovieNotifier(
        localstorageRepository: localStorageRepository,
      );
    });

class StorageMovieNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalstorageRepository localstorageRepository;

  StorageMovieNotifier({required this.localstorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final List<Movie> movies = await localstorageRepository.loadMovies(
      offset: page * 10,
      limit: 20,
    );
    page++;

    final Map<int, Movie> tempMovies = {};

    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};

    return movies;
  }

  Future<void> toggleFavorite(movie) async {
    await localstorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
