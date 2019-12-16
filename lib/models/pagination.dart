class Pagination {
  final int page;
  final int totalPages;
  final int totalResults;

  Pagination({this.page, this.totalPages, this.totalResults});

  static Pagination fromJson(dynamic json) {
    return Pagination(
        page: json['page'] as int,
        totalResults: json['total_results'] as int,
        totalPages: json['total_pages'] as int);
  }

  int previousPage() {
    if ((page == null) || (page == 0) || (page == 1)) {
      return 1;
    }

    if (page == totalPages) {
      return page;
    }

    return page - 1;
  }

  int nextPage() {
    if ((page == null) || (page == 0)) {
      return 1;
    }

    if (page == totalPages) {
      return page;
    }

    return page + 1;
  }
}