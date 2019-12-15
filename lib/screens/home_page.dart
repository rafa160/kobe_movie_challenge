
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:kobe_movie_challenge/screens/details_movie.dart';


class HomePage extends StatelessWidget {

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
            actions: <Widget>[
              Row(
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
                        return Container(
                          margin: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(images+movies[index].posterPath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          movies[index].title,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                  Icons.format_align_justify,color: Colors.black,),
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsMovie()));
                                              },
                                            ),
                                            Text(
                                              "details",
                                              style: TextStyle(fontSize: 10, fontStyle: prefix0.FontStyle.italic,fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
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
                                          movies[index].releaseDate,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 18,),
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${movies[index].genreIds}',
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Divider(
                                      thickness: 8,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                  });
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
        );
      },
    );
  }
}
