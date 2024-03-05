class ChatListModel {
  List<ChatList>? chatList;
  Pagination? pagination;

  ChatListModel({this.chatList, this.pagination});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    if (json['chatList'] != null) {
      chatList = <ChatList>[];
      json['chatList'].forEach((v) {
        chatList!.add(new ChatList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatList != null) {
      data['chatList'] = this.chatList!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class ChatList {
  String? sId;
  List<Participants>? participants;
  String? groupName;
  String? type;
  String? image;
  LatestMessage? latestMessage;
  String? groupAdmin;

  ChatList(
      {this.sId,
        this.participants,
        this.groupName,
        this.type,
        this.image,
        this.latestMessage,
        this.groupAdmin});

  ChatList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    groupName = json['groupName'];
    type = json['type'];
    image = json['image'];
    latestMessage = json['latestMessage'] != null
        ? new LatestMessage.fromJson(json['latestMessage'])
        : null;
    groupAdmin = json['groupAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['groupName'] = this.groupName;
    data['type'] = this.type;
    data['image'] = this.image;
    if (this.latestMessage != null) {
      data['latestMessage'] = this.latestMessage!.toJson();
    }
    data['groupAdmin'] = this.groupAdmin;
    return data;
  }
}

class Participants {
  String? sId;
  String? fullName;
  String? image;

  Participants({this.sId, this.fullName, this.image});

  Participants.fromJson(Map<String, dynamic> json) {
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

class LatestMessage {
  String? sId;
  String? message;
  String? createdAt;

  LatestMessage({this.sId, this.message, this.createdAt});

  LatestMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
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