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
    if (event is FetchMovie) {
      yield MovieLoading();
      try {
        final Movie movie = await movieRepository.getMovie(event.id);
        yield MovieLoaded(movie: movie);
      } catch (_) {
        yield MovieError();
      }
    }

    if (event is FetchUpcomingMovies) {
      yield MoviesLoading();
      try {
        final List<Movie> movies = await movieRepository.getUpcomingList();
        yield UpcomingMoviesLoaded(movies: movies);
      } catch (_) {
        yield MoviesError();
      }
    }
  }
}