class Order {
  String? objectId;
  int? total;
  String? status;
  String? userId;
  List<ProductsInOrder>? productsInOrder;
  String? createdAt;
  String? updatedAt;
  String? rate;

  Order({
    this.objectId,
    this.total,
    this.status,
    this.userId,
    this.productsInOrder,
    this.rate,
  });

  Order.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    total = json['total'];
    status = json['status'];
    rate = json['rate'];
    userId =
        userId = json['userId'] != null ? json['userId']['objectId'] : null;
    if (json['products'] != null) {
      productsInOrder = <ProductsInOrder>[];
      json['products'].forEach((v) {
        productsInOrder!.add(ProductsInOrder.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['status'] = status;
    data['rate'] = rate;
    if (userId != null) {
      data['userId'] = {
        "__type": "Pointer",
        "className": "_User",
        "objectId": userId,
      };
    }
    if (productsInOrder != null) {
      data['products'] = productsInOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsInOrder {
  String? productId;
  int? count;

  ProductsInOrder({this.productId, this.count});

  ProductsInOrder.fromJson(Map<String, dynamic> json) {
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
