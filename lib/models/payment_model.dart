

class PaymentModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  PaymentModel({this.status, this.statusCode, this.message, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;

  Data({this.type, this.attributes, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    data['accessToken'] = this.accessToken;
    return data;
  }
}

class Attributes {
  PaymentInfo? paymentInfo;
  MyUpdatedSubscription? myUpdatedSubscription;

  Attributes({this.paymentInfo, this.myUpdatedSubscription});

  Attributes.fromJson(Map<String, dynamic> json) {
    paymentInfo = json['paymentInfo'] != null
        ? new PaymentInfo.fromJson(json['paymentInfo'])
        : null;
    myUpdatedSubscription = json['myUpdatedSubscription'] != null
        ? new MyUpdatedSubscription.fromJson(json['myUpdatedSubscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo!.toJson();
    }
    if (this.myUpdatedSubscription != null) {
      data['myUpdatedSubscription'] = this.myUpdatedSubscription!.toJson();
    }
    return data;
  }
}

class PaymentInfo {
  PaymentData? paymentData;
  String? subscription;
  String? user;
  String? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PaymentInfo(
      {this.paymentData,
        this.subscription,
        this.user,
        this.status,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    paymentData = json['paymentData'] != null
        ? new PaymentData.fromJson(json['paymentData'])
        : null;
    subscription = json['subscription'];
    user = json['user'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentData != null) {
      data['paymentData'] = this.paymentData!.toJson();
    }
    data['subscription'] = this.subscription;
    data['user'] = this.user;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PaymentData {
  String? paymentId;
  String? paymentMethod;
  double? amount;
  Item? item;

  PaymentData({this.paymentId, this.paymentMethod, this.amount, this.item});

  PaymentData.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    paymentMethod = json['payment_method'];
    amount = json['amount'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentId'] = this.paymentId;
    data['payment_method'] = this.paymentMethod;
    data['amount'] = this.amount;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  String? name;
  String? sku;
  String? price;
  String? currency;
  int? quantity;

  Item({this.name, this.sku, this.price, this.currency, this.quantity});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sku = json['sku'];
    price = json['price'];
    currency = json['currency'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['quantity'] = this.quantity;
    return data;
  }
}

class MyUpdatedSubscription {
  String? sId;
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
  String? createdAt;
  String? updatedAt;
  int? iV;

  MyUpdatedSubscription(
      {this.sId,
        this.user,
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
        this.createdAt,
        this.updatedAt,
        this.iV});

  MyUpdatedSubscription.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}