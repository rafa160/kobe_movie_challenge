import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kobe_movie_challenge/models/movie.dart';
import 'package:kobe_movie_challenge/models/pagination.dart';
import 'package:kobe_movie_challenge/models/response.dart';
import 'package:kobe_movie_challenge/routes/sub_routes/movie_routes.dart';


class MovieApiClient {
  final http.Client httpClient;

  MovieApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Movie> fetchMovie(int movieId) async {
    final movieResponse = await this.httpClient.get(MovieRoutes().movieById(movieId));

    if(movieResponse.statusCode != 200){
      throw Exception('Error');
    }
    final movieJson = jsonDecode(movieResponse.body);
    return Movie.fromJson(movieJson);
  }

  Future<Response> fetchUpcomingMovies({int page}) async {
    final movieResponse = await this.httpClient.get(MovieRoutes().upcomingMovies(page: page));

    if (movieResponse.statusCode != 200){
      throw Exception('Error');
    }

    final upcomingMovieJson = jsonDecode(movieResponse.body);
    final pagination = Pagination.fromJson(upcomingMovieJson);

    final upcomingMoviesJson = jsonDecode(movieResponse.body);
    return Response(object: Movie.fromJsonArray(upcomingMoviesJson),pagination: pagination);
  }

}