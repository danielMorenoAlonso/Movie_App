import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Shell Route para tabs con bottom navigation bar
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeView(),
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                return MovieScreen(
                  movieId: state.pathParameters['id'] ?? 'no-id',
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/favoritos',
          builder: (context, state) => FavoritesView(),
        ),
      ],
    ),

    // Configuracion rutas padre/hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => HomeScreen(childView: HomeView()),
    //   // Se colocan de esta forma las rutas hijas para permitir
    //   // regresar a la navegacion anterior
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         return MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id');
    //       },
    //     ),
    //   ],
    // ),
  ],
);
