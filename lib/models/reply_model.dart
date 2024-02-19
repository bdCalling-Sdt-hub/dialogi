class ReplyModel {
  String reply;

  String fullName;
  String image;

  int likes;

  int dislikes;

  ReplyModel(
      {required this.reply,
      required this.fullName,
      required this.image,
      required this.likes,
      required this.dislikes});

// factory Product.fromJson(Map<String, dynamic> json) {
//   var id = json['id'] ?? "";
//   var name = json['name'] ?? "item";
//   var url = json['url'] ?? "";
//   var price = json['price'] ?? "0";
//   var stockQuantity = json['stock_quantity'] ?? 0;
//
//   return Product(
//       id: id,
//       name: name,
//       url: url,
//       price: price,
//       stockQuantity: stockQuantity);
// }
}
