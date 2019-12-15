import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:bloc/bloc.dart';
import 'package:kobe_movie_challenge/models/movie.dart';
import 'package:kobe_movie_challenge/repositories/movies/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({@required this.movieRepository}) : assert(movieRepository != null);

  @override
  MovieState get initialState => MovieEmpty();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    final currentState = state;
    if (event is FetchMovie) {
      yield MovieLoading();
      try {
        final Movie movie = await movieRepository.getMovie(event.id);
        yield MovieLoaded(movie: movie);
      } catch (_) {
        yield MovieError();
      }
    }

    if (event is FetchUpcomingMoviesNextPage) {
      yield MoviesLoading();
      try {
        var response = (currentState is UpcomingMoviesLoaded)
            ? await movieRepository.getUpcomingList(
                page: currentState.pagination.nextPage())
            : await movieRepository.getUpcomingList();
        yield UpcomingMoviesLoaded(
            movies: response.object, pagination: response.pagination);
      } catch (_) {
        yield MoviesError();
      }
    }

    if (event is FetchUpcomingMoviesPreviousPage) {
      yield MoviesLoading();
      try {
        var response = (currentState is UpcomingMoviesLoaded)
            ? await movieRepository.getUpcomingList(
            page: currentState.pagination.previousPage())
            : await movieRepository.getUpcomingList();

        yield UpcomingMoviesLoaded(
            movies: response.object, pagination: response.pagination);
      } catch (_) {
        yield MoviesError();
      }
    }
  }
}
