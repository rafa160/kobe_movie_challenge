import 'package:equatable/equatable.dart';

class Movie extends Equatable {


  final String posterPath;
  final int id;
  final String backdropPath;
  final List<int> genreIds;
  final String title;
  final String releaseDate;

  const Movie({
    this.posterPath,
    this.id,
    this.backdropPath,
    this.genreIds,
    this.title,
    this.releaseDate,
  });

  @override
  List<Object> get props => [
    posterPath,
    id,
    backdropPath,
    genreIds,
    title,
    releaseDate,
  ];

  static Movie fromJson(dynamic json) {
    // Code this method
    return null;
  }

  static List<Movie> fromJsonArray(dynamic json) {
    // Code this method
    return null;
  }
}