class ProfileModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  ProfileModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? address;
  String? dateOfBirth;

  Attributes(
      {this.sId,
      this.fullName,
      this.email,
      this.password,
      this.image,
      this.role,
      this.subscription,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.address,
      this.dateOfBirth});

  Attributes.fromJson(Map<String, dynamic> json) {
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
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
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
    data['address'] = this.address;
    data['dateOfBirth'] = this.dateOfBirth;
    return data;
  }
}
