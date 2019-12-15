import '../routes.dart';

class MovieRoutes extends Routes {
  static const urlsNameSpace = "/movie";
  static const upcomingMoviesUrl = "/upcoming";

  upcomingMovies({int page}) {
    if (page != null) {
      super.addPageParam(page);
    }

    super.addCustomUrl(urlsNameSpace, urlsNameSpace);
    super.addCustomUrl(upcomingMoviesUrl, upcomingMoviesUrl);
    return super.buildRoute();
  }

  movieById(int id) {
    super.addCustomUrl('movieById', "$urlsNameSpace/$id");
    return super.buildRoute();
  }
}
