import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    // Utilizamos read porque estamos dentro de un state
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
    ref.read(upcomingProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();
    // Usamos watch para estar pendientes de la data actualizada
    final slideShowMovies = ref.watch(movieSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingProvider);
    final topRatedMovies = ref.watch(topRatedProvider);

    return CustomScrollView(
      // Slivers trabajan con los scroll view y reciben una lista de widgets
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),
        SliverList(
          // Delegate espera la función que va a construir los widgets para sliver list
          delegate: SliverChildBuilderDelegate((context, index) {
            // Al ser un builder se construye en tiempo de ejecución
            // y el count va a ser la cantidad de veces que se va a repetir
            // al ponerle 1 es un truco para que solo se repita una vez todo el contenido
            // con la finalidad de tener un custom scroll para el app bar
            return Column(
              children: [
                MoviesSlideshow(movies: slideShowMovies),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Lunes 20',
                  loadNextPage:
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subtitle: 'Este mes',
                  loadNextPage:
                      ref.read(upcomingProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage:
                      ref.read(popularMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  loadNextPage:
                      ref.read(topRatedProvider.notifier).loadNextPage,
                ),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
