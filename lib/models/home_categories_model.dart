
class HomeCategoriesModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  HomeCategoriesModel({this.status, this.statusCode, this.message, this.data});

  HomeCategoriesModel.fromJson(Map<String, dynamic> json) {
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
  List<CategoryList>? categoryList;
  Pagination? pagination;
  List<EarlyAccessList>? earlyAccessList;
  PaginationEr? paginationEr;

  Attributes(
      {this.categoryList,
        this.pagination,
        this.earlyAccessList,
        this.paginationEr});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['categoryList'] != null) {
      categoryList = <CategoryList>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['earlyAccessList'] != null) {
      earlyAccessList = <EarlyAccessList>[];
      json['earlyAccessList'].forEach((v) {
        earlyAccessList!.add(new EarlyAccessList.fromJson(v));
      });
    }
    paginationEr = json['paginationEr'] != null
        ? new PaginationEr.fromJson(json['paginationEr'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryList != null) {
      data['categoryList'] = this.categoryList!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.earlyAccessList != null) {
      data['earlyAccessList'] =
          this.earlyAccessList!.map((v) => v.toJson()).toList();
    }
    if (this.paginationEr != null) {
      data['paginationEr'] = this.paginationEr!.toJson();
    }
    return data;
  }
}

class CategoryList {
  String? sId;
  String? name;
  String? type;
  String? image;
  int? questionCount;
  bool? isEarlyAccessAvailable;

  CategoryList(
      {this.sId,
        this.name,
        this.type,
        this.image,
        this.questionCount,
        this.isEarlyAccessAvailable});

  CategoryList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
    questionCount = json['questionCount'];
    isEarlyAccessAvailable = json['isEarlyAccessAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['image'] = this.image;
    data['questionCount'] = this.questionCount;
    data['isEarlyAccessAvailable'] = this.isEarlyAccessAvailable;
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

class EarlyAccessList {
  String? sId;
  String? name;
  String? type;
  String? image;

  EarlyAccessList({this.sId, this.name, this.type, this.image});

  EarlyAccessList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['image'] = this.image;
    return data;
  }
}

class PaginationEr {
  int? totalResults;
  int? totalPagesEr;
  int? currentPageEr;
  int? limitEr;

  PaginationEr(
      {this.totalResults, this.totalPagesEr, this.currentPageEr, this.limitEr});

  PaginationEr.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    totalPagesEr = json['totalPagesEr'];
    currentPageEr = json['currentPageEr'];
    limitEr = json['limitEr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['totalPagesEr'] = this.totalPagesEr;
    data['currentPageEr'] = this.currentPageEr;
    data['limitEr'] = this.limitEr;
    return data;
  }
}