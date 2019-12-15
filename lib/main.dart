import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobe_movie_challenge/blocs/movies/movies_bloc.dart';
import 'package:kobe_movie_challenge/blocs/simple_bloc_delegate.dart';
import 'package:kobe_movie_challenge/localization.dart';
import 'package:kobe_movie_challenge/repositories/movies/movie_api_client.dart';
import 'package:kobe_movie_challenge/repositories/movies/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:kobe_movie_challenge/screens/home_page.dart';
import 'package:kobe_movie_challenge/screens/login_page.dart';

void main() {
  final MovieRepository movieRepository = MovieRepository(
      movieApiClient: MovieApiClient(httpClient: http.Client())
  );

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(
            create: (context) => MovieBloc(movieRepository: movieRepository),
          )
        ],
        child: KobeMovieChallengeApp(movieRepository: movieRepository),
    ),
  );
}

class KobeMovieChallengeApp extends StatelessWidget {
  final MovieRepository movieRepository;

  KobeMovieChallengeApp({Key key, @required this.movieRepository}) : assert(movieRepository != null), super(key : key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: FlutterBlocLocalizations().appTitle,
      home: LoginPage(),
    );
  }
}

