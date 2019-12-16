import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_state.dart';

class PaginationWidget extends StatelessWidget {
  PaginationWidget({Key key});

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    return BlocBuilder<MovieBloc, MovieState>(builder: (context, active) {
      return Container(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              color: Colors.black87,
              child: Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () {
                movieBloc.add(FetchUpcomingMoviesPreviousPage());
              },
            ),
            FlatButton(
              color: Colors.black87,
              child: active is UpcomingMoviesLoaded ? Text(
                "Page ${active.pagination.page} of ${active.pagination.totalPages}",
                style: TextStyle(color: Colors.white),
              ) : Text("No data"),
              onPressed: () {
//                movieBloc.add(FetchUpcomingMoviesNextPage());
              },
            ),
            FlatButton(
              color: Colors.black87,
              child: Icon(Icons.arrow_forward, color: Colors.white,),
              onPressed: () {
                movieBloc.add(FetchUpcomingMoviesNextPage());
              },
            ),
          ],
        ),
      );
    });
  }
}