import 'package:equatable/equatable.dart';

class Movie extends Equatable {

  final int id;
  final String posterPath;
  final String backdropPath;
  final List<int> genreIds;
  final String title;
  final String releaseDate;

  const Movie({
    this.id,
    this.posterPath,
    this.backdropPath,
    this.genreIds,
    this.title,
    this.releaseDate,
  });

  @override
  List<Object> get props => [
    id,
    posterPath,
    backdropPath,
    genreIds,
    title,
    releaseDate,
  ];

  static Movie fromJson(dynamic json) {
    // Write this method
    return Movie(
      id: json['id'] as int,
      posterPath: json['poster_path'] as String,
      backdropPath: json['backdrop_path'] as String,
      title: json['title'] as String,
      releaseDate: json['release_date'] as String,
    );
  }

  static List<Movie> fromJsonArray(dynamic jsonArray) {
    List<Movie> movies = new List<Movie>();
    for(var i = 0; i < jsonArray['results'].length; i++){
      movies.add(jsonArray[i]);
    }
    return movies;
  }
}