class DiscussionDetailsModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  DiscussionDetailsModel(
      {this.status, this.statusCode, this.message, this.data, });

  DiscussionDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Discussion? discussion;
  Pagination? pagination;

  Attributes({this.discussion, this.pagination});

  Attributes.fromJson(Map<String, dynamic> json) {
    discussion = json['discussion'] != null
        ? new Discussion.fromJson(json['discussion'])
        : null;
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.discussion != null) {
      data['discussion'] = this.discussion!.toJson();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Discussion {
  String? sId;
  String? discussion;
  User? user;
  int? likes;
  int? dislikes;
  List<Replies>? replies;

  Discussion(
      {this.sId,
        this.discussion,
        this.user,
        this.likes,
        this.dislikes,
        this.replies});

  Discussion.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    discussion = json['discussion'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    likes = json['likes'];
    dislikes = json['dislikes'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
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
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? fullName;
  String? image;

  User({this.sId, this.fullName, this.image});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}

class Replies {
  String? sId;
  String? reply;
  RepliesUser? repliesUser;
  int? likes;
  int? dislikes;

  Replies({this.sId, this.reply, this.repliesUser, this.likes, this.dislikes});

  Replies.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reply = json['reply'];
    repliesUser = json['user'] != null ? new RepliesUser.fromJson(json['user']) : null;
    likes = json['likes'];
    dislikes = json['dislikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['reply'] = this.reply;
    if (this.repliesUser != null) {
      data['user'] = this.repliesUser!.toJson();
    }
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    return data;
  }
}

class RepliesUser {
  String? fullName;
  String? image;

  RepliesUser({this.fullName, this.image});

  RepliesUser.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['image'] = this.image;
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