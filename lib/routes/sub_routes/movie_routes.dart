import '../routes.dart';

class MovieRoutes extends Routes {
  static const urlsNameSpace = "/movie";
  static const upcomingMoviesUrl = "/upcoming";

  static upcomingMovies() {
    return Routes.buildRoute("$urlsNameSpace$upcomingMoviesUrl");
  }

  static movieById(int id) {
    return Routes.buildRoute("$urlsNameSpace/$id");
  }
}
