class JokeSearchModel {
  int? currentPage;
  int? limit;
  int? nextPage;
  int? previousPage;
  List<Result>? results;
  String? searchTerm;
  int? status;
  int? totalJokes;
  int? totalPages;

  JokeSearchModel(
      {this.currentPage,
      this.limit,
      this.nextPage,
      this.previousPage,
      this.results,
      this.searchTerm,
      this.status,
      this.totalJokes,
      this.totalPages});

  JokeSearchModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    limit = json['limit'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(new Result.fromJson(v));
      });
    }
    searchTerm = json['search_term'];
    status = json['status'];
    totalJokes = json['total_jokes'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['limit'] = this.limit;
    data['next_page'] = this.nextPage;
    data['previous_page'] = this.previousPage;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['search_term'] = this.searchTerm;
    data['status'] = this.status;
    data['total_jokes'] = this.totalJokes;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class Result {
  String? id;
  String? joke;

  Result({this.id, this.joke});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joke = json['joke'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['joke'] = this.joke;
    return data;
  }
}
