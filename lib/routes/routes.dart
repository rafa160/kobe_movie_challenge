class Routes {
  static const rootUrl = "https://api.themoviedb.org";
  static const baseApiVersion = "/3";
  static const apiKey = "api_key=c5850ed73901b8d268d0898a8a9d8bff";
  static const language =  "language=en-US";

  static buildRoute(String customRoute){
    return "$rootUrl$baseApiVersion$customRoute?$apiKey&$language";
  }
}