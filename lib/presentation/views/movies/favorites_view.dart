import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
// import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';
// import 'package:cinemapedia/domain/entities/movie.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    isLastPage = movies.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // NOOB final favoriteMovies = ref.watch(favoriteMoviesProvider);
    // List<Movie> listMoviesFavorites = [];
    // favoriteMovies.forEach((key, value) {
    //   listMoviesFavorites.add(value);
    // });
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.heart_broken, color: colors.primary, size: 60),
            Text(
              'Oh no!!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: colors.primary,
              ),
            ),
            const Text(
              'No tienes películas favoritas',
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () {
                context.go('/home/0');
              },
              child: Text('Empieza a buscar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(movies: favoriteMovies, loadNextPage: loadNextPage),
    );
  }
}
