class AccessStatusModel {
  String? status;
  String? message;
  Data? data;

  AccessStatusModel({this.status, this.message, this.data});

  AccessStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? user;
  String? type;
  bool? isAddAvailable;
  int? categoryAccessNumber;
  bool? isCategoryAccessUnlimited;
  int? questionAccessNumber;
  bool? isQuestionAccessUnlimited;
  bool? isChatAvailable;
  bool? isGroupChatAvailable;
  bool? isCommunityDiscussionAvailable;
  bool? isEarlyAccessAvailable;
  bool? updateProfileAccess;
  int? expiryTime;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.user,
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
      this.expiryTime,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
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
    expiryTime = json['expiryTime'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
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
    data['expiryTime'] = this.expiryTime;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
