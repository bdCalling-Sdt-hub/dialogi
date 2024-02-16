class QuestionAnsModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  QuestionAnsModel(
      {this.status, this.statusCode, this.message, this.data,});

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

  Attributes({this.questions, this.pagination});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Questions {
  String? sId;
  String? question;
  String? subCategory;
  List<Discussions>? discussions;

  Questions({this.sId, this.question, this.subCategory, this.discussions});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    subCategory = json['subCategory'];
    if (json['discussions'] != null) {
      discussions = <Discussions>[];
      json['discussions'].forEach((v) {
        discussions!.add(new Discussions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['subCategory'] = this.subCategory;
    if (this.discussions != null) {
      data['discussions'] = this.discussions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Discussions {
  String? sId;
  String? discussion;
  int? totalReplies;
  int? likes;
  int? dislikes;
  User? user;
  List<LimitedReplies>? limitedReplies;

  Discussions(
      {this.sId,
        this.discussion,
        this.totalReplies,
        this.likes,
        this.dislikes,
        this.user,
        this.limitedReplies});

  Discussions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    discussion = json['discussion'];
    totalReplies = json['totalReplies'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['limitedReplies'] != null) {
      limitedReplies = <LimitedReplies>[];
      json['limitedReplies'].forEach((v) {
        limitedReplies!.add(new LimitedReplies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['discussion'] = this.discussion;
    data['totalReplies'] = this.totalReplies;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.limitedReplies != null) {
      data['limitedReplies'] =
          this.limitedReplies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? fullName;
  String? email;
  String? password;
  String? image;
  String? role;
  String? subscription;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
        this.fullName,
        this.email,
        this.password,
        this.image,
        this.role,
        this.subscription,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    role = json['role'];
    subscription = json['subscription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['image'] = this.image;
    data['role'] = this.role;
    data['subscription'] = this.subscription;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class LimitedReplies {
  String? sId;
  String? reply;
  String? discussion;
  User? user;
  int? likes;
  int? dislikes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LimitedReplies(
      {this.sId,
        this.reply,
        this.discussion,
        this.user,
        this.likes,
        this.dislikes,
        this.createdAt,
        this.updatedAt,
        this.iV});

  LimitedReplies.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reply = json['reply'];
    discussion = json['discussion'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    likes = json['likes'];
    dislikes = json['dislikes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['reply'] = this.reply;
    data['discussion'] = this.discussion;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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