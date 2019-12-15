
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:kobe_movie_challenge/models/movie.dart';
import 'package:kobe_movie_challenge/widgets/movie_tile.dart';
import 'package:kobe_movie_challenge/widgets/movies_tile.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  MovieBloc movieBloc;
  String search;
  var moviesList = List<Movie>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(FetchUpcomingMovies());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      print("MAXXED OUT");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, active) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
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
            color: Colors.black87,
            padding: EdgeInsets.all(8),
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is UpcomingMoviesLoaded) {
                  final movies = state.movies;
                  return ListView.builder(
                    controller: _scrollController,
                      itemCount: movies.length + 1,
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
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white,
                          ),
                          strokeWidth: 10.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Waiting you to search...", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomSheet: Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  color: Colors.black87,
                  child: Text("<", style: TextStyle(fontSize: 18, color: Colors.white),),
                  onPressed: (){
                    movieBloc.add(FetchUpcomingMoviesPreviousPage());
                  },
                ),
                FlatButton(
                  color: Colors.black87,
                  child: Text(
                    "Upcoming Movies here!",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    movieBloc.add(FetchUpcomingMoviesNextPage());
                  },
                ),
                FlatButton(
                  color: Colors.black87,
                  child: Text(">", style: TextStyle(fontSize: 18, color: Colors.white),),
                  onPressed: (){
                    movieBloc.add(FetchUpcomingMoviesNextPage());
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
