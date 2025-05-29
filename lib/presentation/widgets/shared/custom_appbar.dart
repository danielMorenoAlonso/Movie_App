import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              SizedBox(width: 5),
              Text('Cinemapedia', style: textStyle),
              Spacer(),
              IconButton(
                onPressed: () async {
                  // TODO: Esta implementación es sin el provider
                  // final movieRepository = ref.read(movieRepositoryProvider);
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  final movie = await showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      // Esta implementacion es con el provider que se encarga de
                      // actualizar tambien el state del query
                      initialMovies: searchedMovies,
                      searchMovies:
                          ref
                              .read(searchedMoviesProvider.notifier)
                              .searchMoviesByQuery,
                      // TODO: Esta implementación es sin el provider
                      //searchMovies: (query) {
                      //   ref
                      //       .read(searchQueryProvider.notifier)
                      //       .update((state) => query);
                      //   return movieRepository.searchMovies(query);
                      // },
                    ),
                  );
                  if (movie != null && context.mounted) {
                    context.push('/home/0/movie/${movie.id}');
                  }
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
