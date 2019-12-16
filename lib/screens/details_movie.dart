import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:kobe_movie_challenge/models/movie.dart';
import 'package:kobe_movie_challenge/widgets/movie_details_tile_widget.dart';

class DetailsMovie extends StatelessWidget {
  final Movie movie;
  DetailsMovie({Key key, this.movie});
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, active) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Movie Details',
              textAlign: TextAlign.center,
            ),
          ),
          body: DetailsTile(
            movie: movie,
          ),
        );
      },
    );
  }
}
