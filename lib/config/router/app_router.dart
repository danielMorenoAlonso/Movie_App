import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(),
      // Se colocan de esta forma las rutas hijas para permitir
      // regresar a la navegacion anterior
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            return MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id');
          },
        ),
      ],
    ),
  ],
);
