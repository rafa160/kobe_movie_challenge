import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';
import 'package:kobe_movie_challenge/models/movie.dart';
import 'package:kobe_movie_challenge/screens/details_movie.dart';

class MovieTile extends StatelessWidget {
  String images = 'https://image.tmdb.org/t/p/w500/';
  final Movie movie;
  MovieTile({Key key, this.movie});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
    builder: (context, active) {
      return     Container(
        child: Column(
          children: <Widget>[
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
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.format_align_justify,color: Colors.black,),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsMovie(FetchMovie(id:movie.id))));
                            },
                          ),
                          Text(
                            "details",
                            style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
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
                        movie.releaseDate,
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
                          ""
                      ),
                    ],
                  ),
                  Divider(),
                  Divider(
                    thickness: 8,
                    color: Colors.black,
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
