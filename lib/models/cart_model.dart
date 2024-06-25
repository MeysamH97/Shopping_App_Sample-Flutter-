class Cart {
  String? objectId;
  String? userId;
  List<ProductsInCart>? productsInCart;
  int? total;
  String? createdAt;
  String? updatedAt;

  Cart(
      {this.objectId,
      this.userId,
      this.productsInCart,
      this.total,
      this.createdAt,
      this.updatedAt});

  Cart.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    userId = json['userId'] != null ? json['userId']['objectId'] : null;
    if (json['products'] != null) {
      productsInCart = <ProductsInCart>[];
      json['products'].forEach((v) {
        productsInCart!.add(ProductsInCart.fromJson(v));
      });
    }
    total = json['total'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userId != null) {
      data['userId'] = {
        "__type": "Pointer",
        "className": "_User",
        "objectId": userId,
      };
    }
    if (productsInCart != null) {
      data['products'] = productsInCart!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class ProductsInCart {
  String? productId;
  int? count;

  ProductsInCart({this.productId, this.count});

  ProductsInCart.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['count'] = count;
    return data;
  }
}
