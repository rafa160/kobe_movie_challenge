class Routes {
  final baseUrl = {
    'rootUrl': "https://api.themoviedb.org",
    'baseApiVersion': "/3",
  };

  Map<String, String> customUrls = Map();

  final baseQueryParameters = {
    'api_key': "c5850ed73901b8d268d0898a8a9d8bff",
    'language': "en-US"
  };

  Map<String, String> customQueryParameters = Map();

  // need check to see if works
  String buildRoute() {
    String url = this._buildRouteFromUrl();
    String queryParams = this._buildRouteFromQueryParameters();

    this._clearCustomUrls();
    this._clearCustomQueryParameters();

    return "$url$queryParams";
  }

  void addPageParam(int page) {
    this._addCustomParam("page", "$page");
  }

  void addCustomUrl(String urlKey, paramValue) {
    this.customUrls.putIfAbsent(urlKey, () => paramValue);
  }

  String _buildRouteFromUrl() {
    var url = this._dealWithUrls('', baseUrl);
    var finalUrl = this._dealWithUrls(url, customUrls);

    return finalUrl;
  }

  String _buildRouteFromQueryParameters() {
    var baseParams = this._dealWithQueryParams('', baseQueryParameters);
    var params = this._dealWithQueryParams(baseParams, customQueryParameters);

    return params;
  }

  String _dealWithQueryParams(String entry, Map query) {
    var params = "$entry";
    query.forEach((key, value) {
      params += "${params == "" ? "?" : "&"}$key=$value";
    });

    return params;
  }

  String _dealWithUrls(String entry, Map query) {
    var url = "$entry";
    query.forEach((key, value) {
      url += value;
    });
    return url;
  }

  void _addCustomParam(String paramKey, paramValue) {
    this.customQueryParameters.putIfAbsent(paramKey, () => paramValue);
  }

  void _clearCustomQueryParameters() {
    this.customQueryParameters = Map();
  }

  void _clearCustomUrls() {
    this.customUrls = Map();
  }
}