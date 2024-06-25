class OrdersList {
  String? objectId;
  List<Orders>? orders;
  String? userId;

  OrdersList({this.objectId, this.orders, this.userId});

  OrdersList.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    userId =
        userId = json['userId'] != null ? json['userId']['objectId'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (userId != null) {
      data['userId'] = {
        "__type": "Pointer",
        "className": "_User",
        "objectId": userId,
      };
    }
    return data;
  }
}

class Orders {
  String? orderId;

  Orders({this.orderId});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['objectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = orderId;
    return data;
  }
}