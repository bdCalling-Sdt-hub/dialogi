
class SearchFriendsModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  SearchFriendsModel({this.status, this.statusCode, this.message, this.data});

  SearchFriendsModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  Attributes? attributes;

  Data({this.type, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  List<UserList>? userList;
  Pagination? pagination;

  Attributes({this.userList, this.pagination});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['userList'] != null) {
      userList = <UserList>[];
      json['userList'].forEach((v) {
        userList!.add(new UserList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userList != null) {
      data['userList'] = this.userList!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class UserList {
  String? sId;
  String? fullName;
  String? email;
  String? password;
  bool? isDeleted;
  String? image;
  String? role;
  String? subscription;
  bool? loginInWithProvider;
  int? iV;
  String? createdAt;
  String? updatedAt;
  String? subscriptionId;

  UserList(
      {this.sId,
        this.fullName,
        this.email,
        this.password,
        this.isDeleted,
        this.image,
        this.role,
        this.subscription,
        this.loginInWithProvider,
        this.iV,
        this.createdAt,
        this.updatedAt,
        this.subscriptionId});

  UserList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    isDeleted = json['isDeleted'];
    image = json['image'];
    role = json['role'];
    subscription = json['subscription'];
    loginInWithProvider = json['loginInWithProvider'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    subscriptionId = json['subscriptionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['isDeleted'] = this.isDeleted;
    data['image'] = this.image;
    data['role'] = this.role;
    data['subscription'] = this.subscription;
    data['loginInWithProvider'] = this.loginInWithProvider;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['subscriptionId'] = this.subscriptionId;
    return data;
  }
}

class Pagination {
  int? totalResults;
  int? totalPages;
  int? currentPage;
  int? limit;
  int? totalUsers;

  Pagination(
      {this.totalResults,
        this.totalPages,
        this.currentPage,
        this.limit,
        this.totalUsers});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    limit = json['limit'];
    totalUsers = json['totalUsers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    data['limit'] = this.limit;
    data['totalUsers'] = this.totalUsers;
    return data;
  }
}