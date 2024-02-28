class DiscussionDetailsModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  DiscussionDetailsModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

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
  String? createdAt;
  List<Replies>? replies;
  bool? isLiked;
  bool? isDisliked;

  Discussion(
      {this.sId,
      this.discussion,
      this.user,
      this.likes,
      this.dislikes,
      this.createdAt,
      this.replies,
      this.isLiked,
      this.isDisliked});

  Discussion.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    discussion = json['discussion'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    likes = json['likes'];
    dislikes = json['dislikes'];
    createdAt = json['createdAt'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
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
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
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

class Replies {
  String? sId;
  String? reply;
  User? user;
  int? likes;
  int? dislikes;
  String? createdAt;
  bool? isLiked;
  bool? isDisliked;

  Replies(
      {this.sId,
      this.reply,
      this.user,
      this.likes,
      this.dislikes,
      this.createdAt,
      this.isLiked,
      this.isDisliked});

  Replies.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reply = json['reply'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    likes = json['likes'];
    dislikes = json['dislikes'];
    createdAt = json['createdAt'];
    isLiked = json['isLiked'];
    isDisliked = json['isDisliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['reply'] = this.reply;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    data['createdAt'] = this.createdAt;
    data['isLiked'] = this.isLiked;
    data['isDisliked'] = this.isDisliked;
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
