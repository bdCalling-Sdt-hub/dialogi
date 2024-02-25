
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
  String? clientSecret;

  Attributes({this.clientSecret});

  Attributes.fromJson(Map<String, dynamic> json) {
    clientSecret = json['client_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_secret'] = this.clientSecret;
    return data;
  }
}