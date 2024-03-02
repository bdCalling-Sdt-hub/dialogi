class CommunityRequestModel {
  String? status;
  String? statusCode;
  Data? data;

  CommunityRequestModel({this.status, this.statusCode, this.data,});

  CommunityRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
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
  List<CommunityRequestList>? communityRequestList;
  Pagination? pagination;

  Attributes({this.communityRequestList, this.pagination});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['communityRequestList'] != null) {
      communityRequestList = <CommunityRequestList>[];
      json['communityRequestList'].forEach((v) {
        communityRequestList!.add(new CommunityRequestList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.communityRequestList != null) {
      data['communityRequestList'] =
          this.communityRequestList!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class CommunityRequestList {
  String? sId;
  Chat? chat;
  String? createdAt;

  CommunityRequestList({this.sId, this.chat, this.createdAt});

  CommunityRequestList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chat = json['chat'] != null ? new Chat.fromJson(json['chat']) : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Chat {
  String? sId;
  String? groupName;
  String? image;

  Chat({this.sId, this.groupName, this.image});

  Chat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['groupName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['groupName'] = this.groupName;
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