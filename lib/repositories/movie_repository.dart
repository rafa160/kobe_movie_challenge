import 'package:flutter/cupertino.dart';
import 'package:kobe_movie_challenge/models/movie.dart';
import 'package:kobe_movie_challenge/repositories/movie_api_client.dart';

class MovieRepository {
  final MovieApiClient movieApiClient;

  MovieRepository({@required this.movieApiClient}) : assert(movieApiClient != null);

  Future<Movie> getMovie(int id) async {
    return await movieApiClient.fetchMovie(id);
  }

  Future<List<Movie>> getUpcomingList() async {
    return await movieApiClient.fetchUpcomingMovies();
  }

}