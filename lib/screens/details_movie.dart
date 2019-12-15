import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';

class DetailsMovie extends StatelessWidget {
  DetailsMovie(context);
  String images = 'https://image.tmdb.org/t/p/w500/';
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, active) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 64, 106, 1),
            title: Text(
              "Movie Detail",
              textAlign: TextAlign.center,
            ),
          ),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                double maxWidth = MediaQuery.of(context).size.width * 0.7;
                if (state is MovieLoaded) {
                  final movie = state.movie;
                  return Center(
                    child: ListView(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(images+movie.posterPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              movie.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Release Date: ",
                              style: TextStyle(
                                fontSize: 15,),
                            ),
                            Text(
                              movie.releaseDate,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 18,),
                            )
                          ],
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          child: Text("Description: " + movie.overview),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '${movie.genreIds}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                if(state is MoviesLoading) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(247, 64, 106, 1.0),
                        ),
                        strokeWidth: 10.0,
                      ),
                    ),
                  );
                }

                return Center(child: Text("Error!"),);
              },
            ),
          ),
        );
      },
    );
  }
}
