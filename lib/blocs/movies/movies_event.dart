import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class  FetchMovie extends MovieEvent {
  final int id;

  const FetchMovie({@required this.id}) : assert(id != null);

  @override
  List<Object> get props => [id];
}

class FetchUpcomingMovies extends MovieEvent {

  const FetchUpcomingMovies();

  @override
  // TODO: implement props
  List<Object> get props => null;
}