
import 'user_model.dart';

class Product {
  String? objectId;
  String? title;
  String? categoryId;
  int? price;
  String? description;
  ProductImage? image;
  int? stock;
  List<Rate>? rate;
  int? buyCounter;
  List<Comments>? comments;
  List<String>? likes;

  Product(
      {this.objectId,
        this.title,
        this.categoryId,
        this.price,
        this.description,
        this.image,
        this.stock,
        this.rate,
        this.buyCounter,
        this.comments,
        this.likes,
      });

  Product.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    title = json['title'];
    categoryId = json['categoryId'] != null
        ? json['categoryId']['objectId']
        : null;
    price = json['price'];
    description = json['description'];
    image = json['image'] != null ? ProductImage.fromJson(json['image']) : null;
    stock = json['stock'];
    if (json['rate'] != null){
      rate = <Rate>[];
      json['rate'].forEach((v) {
        rate!.add(Rate.fromJson(v));
      });
    }
    buyCounter = json['buyCounter'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <String>[];
      json['likes'].forEach(
            (v) {
          likes!.add(v);
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (categoryId != null) {
      data['categoryId'] = {
        "__type": "Pointer",
        "className": "Category",
        "objectId": categoryId,
      };
    }
    data['price'] = price;
    data['description'] = description;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['stock'] = stock;
    if (rate != null) {
      data['rate'] = rate!.map((v) => v.toJson()).toList();
    }
    data['buyCounter'] = buyCounter;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (likes != null) {
      data['likes'] = likes!;
    } else {
      data['likes'] = [];
    }
    return data;
  }
}

class ProductImage {
  String? sType;
  String? name;
  String? url;

  ProductImage({this.sType, this.name, this.url});

  ProductImage.fromJson(Map<String, dynamic> json) {
    sType = json['__type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__type'] = sType;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Rate {
  double? quality;
  double? price;

  Rate({this.quality, this.price});

  Rate.fromJson(Map<String, dynamic> json) {
    quality = double.parse('${json['quality']}');
    price = double.parse('${json['price']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quality'] = quality;
    data['price'] = price;

    return data;
  }
}

class Comments {
  User? user;
  String? comment;

  Comments({this.user, this.comment});

  Comments.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['comment'] = comment;

    return data;
  }
}

