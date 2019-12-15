
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:kobe_movie_challenge/widgets/movie_tile.dart';
import 'package:kobe_movie_challenge/widgets/movies_tile.dart';


class HomePage extends StatelessWidget {

  String images = 'https://image.tmdb.org/t/p/w500/';

  String search;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, active) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 64, 106, 1),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  var randomizer = new Random();
                  movieBloc.add(FetchMovie(id: randomizer.nextInt(600000)));
                  //access your bloc
                },
              ),
            ],
          ),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is UpcomingMoviesLoaded) {
                  final movies = state.movies;
                  return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MoviesTile(
                          movies: movies[index],
                        );
                  });
                }
                if(state is MovieLoaded){
                  final movie = state.movie;
                  return  ListView(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(images + movie.posterPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      MovieTile(
                        movie: movie,
                      ),
                    ],
                  );
                }
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(247, 64, 106, 1.0),
                          ),
                          strokeWidth: 10.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Waiting you to search...")
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomSheet: Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              color: Color.fromRGBO(247, 64, 106, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  FlatButton(
                    child: Text(
                      "Upcoming Movies here!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      movieBloc.add(FetchUpcomingMovies());
                    },
                  ),
                ],
              ),
            ),

        );
      },
    );
  }
}
