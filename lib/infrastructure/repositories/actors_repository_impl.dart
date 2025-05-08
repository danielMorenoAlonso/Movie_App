import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';

import 'package:cinemapedia/domain/repositores/actors_repository.dart';

// Se extiende del repositorio pero le mandamos un datasource

// El objetivo de la implementacion es que el provider
// pueda obtener la informacion de cualquier datasource

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsMovie(String movieId) {
    return datasource.getActorsMovie(movieId);
  }
}
