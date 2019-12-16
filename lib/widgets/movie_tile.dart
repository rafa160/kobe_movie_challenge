import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:kobe_movie_challenge/models/movie.dart';
import 'package:kobe_movie_challenge/screens/details_movie.dart';
import 'package:kobe_movie_challenge/widgets/movie_details_tile_widget.dart';

class MovieTile extends StatelessWidget {
  String images = 'https://image.tmdb.org/t/p/w500/';
  final Movie movie;

  MovieTile({Key key, this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(builder: (context, active) {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DetailsMovie(movie: movie)));
        },
        child: Container(
          child: new Card(
            elevation: 4.0,
            child: Image.network(
              images + movie.posterPath,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    });
  }
}
