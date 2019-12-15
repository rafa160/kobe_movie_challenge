import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:kobe_movie_challenge/models/movie.dart';

class DetailsTile extends StatelessWidget {
  String images = 'https://image.tmdb.org/t/p/w500/';
  final Movie movie;
  DetailsTile({Key key, this.movie});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
        builder: (context, active) {
          double maxWidth = MediaQuery.of(context).size.width * 0.7;
          return Container(
            padding: EdgeInsets.only(bottom: 55,top: 1),
            margin: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.network(images+movie.posterPath,
                        fit: BoxFit.cover,
                      ),

                    ],
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
                            movie.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Release Date: ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,),
                          ),
                          Text(
                            movie.releaseDate,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '${movie.genreIds}',style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Text("Description: " + movie.overview, style: TextStyle(color: Colors.white),textAlign: TextAlign.left,),
                      ),
                      Divider(),
                      Divider(
                        thickness: 8,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );

  }
}
