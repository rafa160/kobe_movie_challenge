import 'package:flutter/material.dart';
import 'package:kobe_movie_challenge/models/movie.dart';

class MoviesTile extends StatelessWidget {
  String images = 'https://image.tmdb.org/t/p/w500/';
  final Movie movies;
  MoviesTile({Key key, this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 50,top: 1),
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(images+movies.posterPath,
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
                      movies.title,
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
                      movies.releaseDate,
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
                      '${movies.genreIds}',
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
}
