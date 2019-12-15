import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_event.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    return Center(
      child: Container(
          color: Color.fromRGBO(247, 64, 106, 1.0),
          child: RaisedButton(
            child: Text(
              "Teste"
            ),
            onPressed: (){
              movieBloc.add(FetchUpcomingMovies());
            },
          )
      ),
    );
  }
}
