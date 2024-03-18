class QuestionAnsModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  QuestionAnsModel({this.status, this.statusCode, this.message, this.data});

  QuestionAnsModel.fromJson(Map<String, dynamic> json) {
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
  List<Questions>? questions;
  Pagination? pagination;
  Pagination? discussionPagination;

  Attributes({this.questions, this.pagination, this.discussionPagination});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    discussionPagination = json['discussionPagination'] != null
        ? new Pagination.fromJson(json['discussionPagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.discussionPagination != null) {
      data['discussionPagination'] = this.discussionPagination!.toJson();
    }
    return data;
  }
}

class Questions {
  String? sId;
  String? question;
  String? questionGr;
  String? subCategory;
  bool? isEarlyAccessAvailable;
  List<Discussions>? discussions;
  bool? isFavourite;

  Questions(
      {this.sId,
        this.question,
        this.questionGr,
        this.subCategory,
        this.isEarlyAccessAvailable,
        this.discussions,
        this.isFavourite});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    questionGr = json['questionGr'];
    subCategory = json['subCategory'];
    isEarlyAccessAvailable = json['isEarlyAccessAvailable'];
    if (json['discussions'] != null) {
      discussions = <Discussions>[];
      json['discussions'].forEach((v) {
        discussions!.add(new Discussions.fromJson(v));
      });
    }
    isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['questionGr'] = this.questionGr;
    data['subCategory'] = this.subCategory;
    data['isEarlyAccessAvailable'] = this.isEarlyAccessAvailable;
    if (this.discussions != null) {
      data['discussions'] = this.discussions!.map((v) => v.toJson()).toList();
    }
    data['isFavourite'] = this.isFavourite;
    return data;
  }
}

class Discussions {
  String? sId;
  String? discussion;
  User? user;
  int? likes;
  int? dislikes;
  String? createdAt;
  int? totalReplies;
  bool? isLiked;
  bool? isDisliked;

  Discussions(
      {this.sId,
        this.discussion,
        this.user,
        this.likes,
        this.dislikes,
        this.createdAt,
        this.totalReplies,
        this.isLiked,
        this.isDisliked});

  Discussions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    discussion = json['discussion'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    likes = json['likes'];
    dislikes = json['dislikes'];
    createdAt = json['createdAt'];
    totalReplies = json['totalReplies'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['discussion'] = this.discussion;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    data['createdAt'] = this.createdAt;
    data['totalReplies'] = this.totalReplies;
    data['isLiked'] = this.isLiked;
    data['isDisliked'] = this.isDisliked;
    return data;
  }
}

class User {
  String? fullName;
  String? image;
  String? sId;

  User({this.fullName, this.image, this.sId});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    image = json['image'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['image'] = this.image;
    data['_id'] = this.sId;
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