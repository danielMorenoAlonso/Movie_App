import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/actor.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final actors = ref.watch(actorRepositoryProvier);
      return ActorsByMovieNotifier(getActors: actors.getActorsMovie);
    });

/* Se espera devolver un mapa de tipo
    {
      '554302'=>List<Actor()>,
      '554303'=>List<Actor()>,
      '554304'=>List<Actor()>,
      '554305'=>List<Actor()>,
    }

    */

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
