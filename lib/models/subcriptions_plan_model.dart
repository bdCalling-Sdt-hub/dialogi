
class SubscriptionsPlanModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  SubscriptionsPlanModel({this.status, this.statusCode, this.message, this.data});

  SubscriptionsPlanModel.fromJson(Map<String, dynamic> json) {
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
  List<SubscriptionsList>? subscriptionsList;
  Pagination? pagination;

  Attributes({this.subscriptionsList, this.pagination});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['subscriptionsList'] != null) {
      subscriptionsList = <SubscriptionsList>[];
      json['subscriptionsList'].forEach((v) {
        subscriptionsList!.add(new SubscriptionsList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptionsList != null) {
      data['subscriptionsList'] =
          this.subscriptionsList!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class SubscriptionsList {
  String? sId;
  String? name;
  String? type;
  bool? isAddAvailable;
  num? categoryAccessNumber;
  bool? isCategoryAccessUnlimited;
  num? questionAccessNumber;
  bool? isQuestionAccessUnlimited;
  bool? isChatAvailable;
  bool? isGroupChatAvailable;
  bool? isCommunityDiscussionAvailable;
  bool? isEarlyAccessAvailable;
  bool? updateProfileAccess;
  num? price;
  num? expiryTime;
  num? iV;
  String? createdAt;
  String? updatedAt;
  num? addFrequency;

  SubscriptionsList(
      {this.sId,
        this.name,
        this.type,
        this.isAddAvailable,
        this.categoryAccessNumber,
        this.isCategoryAccessUnlimited,
        this.questionAccessNumber,
        this.isQuestionAccessUnlimited,
        this.isChatAvailable,
        this.isGroupChatAvailable,
        this.isCommunityDiscussionAvailable,
        this.isEarlyAccessAvailable,
        this.updateProfileAccess,
        this.price,
        this.expiryTime,
        this.iV,
        this.createdAt,
        this.updatedAt,
        this.addFrequency});

  SubscriptionsList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    isAddAvailable = json['isAddAvailable'];
    categoryAccessNumber = json['categoryAccessNumber'];
    isCategoryAccessUnlimited = json['isCategoryAccessUnlimited'];
    questionAccessNumber = json['questionAccessNumber'];
    isQuestionAccessUnlimited = json['isQuestionAccessUnlimited'];
    isChatAvailable = json['isChatAvailable'];
    isGroupChatAvailable = json['isGroupChatAvailable'];
    isCommunityDiscussionAvailable = json['isCommunityDiscussionAvailable'];
    isEarlyAccessAvailable = json['isEarlyAccessAvailable'];
    updateProfileAccess = json['updateProfileAccess'];
    price = json['price'];
    expiryTime = json['expiryTime'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    addFrequency = json['addFrequency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['isAddAvailable'] = this.isAddAvailable;
    data['categoryAccessNumber'] = this.categoryAccessNumber;
    data['isCategoryAccessUnlimited'] = this.isCategoryAccessUnlimited;
    data['questionAccessNumber'] = this.questionAccessNumber;
    data['isQuestionAccessUnlimited'] = this.isQuestionAccessUnlimited;
    data['isChatAvailable'] = this.isChatAvailable;
    data['isGroupChatAvailable'] = this.isGroupChatAvailable;
    data['isCommunityDiscussionAvailable'] =
        this.isCommunityDiscussionAvailable;
    data['isEarlyAccessAvailable'] = this.isEarlyAccessAvailable;
    data['updateProfileAccess'] = this.updateProfileAccess;
    data['price'] = this.price;
    data['expiryTime'] = this.expiryTime;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['addFrequency'] = this.addFrequency;
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