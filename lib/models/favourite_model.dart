class FavouriteModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  FavouriteModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Attributes? attributes;

  Data({this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  List<FavouriteList>? favouriteList;
  Pagination? pagination;

  Attributes({this.favouriteList, this.pagination});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['favouriteList'] != null) {
      favouriteList = <FavouriteList>[];
      json['favouriteList'].forEach((v) {
        favouriteList!.add(new FavouriteList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favouriteList != null) {
      data['favouriteList'] =
          this.favouriteList!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class FavouriteList {
  String? sId;
  Question? question;

  FavouriteList({this.sId, this.question});

  FavouriteList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    return data;
  }
}

class Question {
  String? sId;
  String? question;

  Question({this.sId, this.question});

  Question.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    return data;
  }
}

class Pagination {
  int? totalResults;
  int? totalPages;
  int? currentPage;
  int? limit;

  Pagination(
      {this.totalResults, this.totalPages, this.currentPage, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    data['limit'] = this.limit;
    return data;
  }
}
