import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kobe_movie_challenge/models/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {}

class MovieLoaded extends MovieState {
  final Movie movie;

  const MovieLoaded({@required this.movie}) : assert(movie != null);

  @override
  List<Object> get props => [movie];
}

class MoviesEmpty extends MovieState {}

class MoviesLoading extends MovieState {}

class MoviesError extends MovieState {}

class UpcomingMoviesLoaded extends MovieState {
  final List<Movie> movies;

  const UpcomingMoviesLoaded({@required this.movies}) : assert(movies != null);

  @override
  List<Object> get props => [movies];
}
