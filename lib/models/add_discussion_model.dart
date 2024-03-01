class AddDiscussionModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  AddDiscussionModel(
      {this.status, this.statusCode, this.message, this.data});

  AddDiscussionModel.fromJson(Map<String, dynamic> json) {
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
  String? discussion;
  String? question;
  String? user;
  int? likes;
  int? dislikes;
  int? order;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Attributes(
      {this.discussion,
        this.question,
        this.user,
        this.likes,
        this.dislikes,
        this.order,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Attributes.fromJson(Map<String, dynamic> json) {
    discussion = json['discussion'];
    question = json['question'];
    user = json['user'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    order = json['order'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discussion'] = this.discussion;
    data['question'] = this.question;
    data['user'] = this.user;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    data['order'] = this.order;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}