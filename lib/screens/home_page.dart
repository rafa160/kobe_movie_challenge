import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:kobe_movie_challenge/models/movie.dart';
import 'package:kobe_movie_challenge/widgets/delegate/data_search_app.dart';
import 'package:kobe_movie_challenge/widgets/movie_tile.dart';
import 'package:kobe_movie_challenge/widgets/pagination_widget.dart';

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
    movieBloc.add(FetchUpcomingMoviesNextPage());
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
            title: Text("Kobe Challanger", style: TextStyle(),textAlign: TextAlign.center,),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: Teste());
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
                  return GridView.builder(
                      itemCount: movies.length,
                      padding: EdgeInsets.only(bottom: 70),
                      controller: _scrollController,
                      gridDelegate:
                      new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 1.0),
                      itemBuilder: (BuildContext context, int index) {
                        return MovieTile(
                          movie: movies[index],
                        );
                      });
                }
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 10.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Waiting you to search...",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomSheet: PaginationWidget(),
        );
      },
    );
  }
}
