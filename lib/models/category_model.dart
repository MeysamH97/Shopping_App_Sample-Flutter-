
class Category {
  String? objectId;
  String? title;
  CategoryImage? image;

  Category({this.objectId, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    title = json['title'];
    image = json['categoryImage'] != null
        ? CategoryImage.fromJson(json['categoryImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['title'] = title;
    if (image != null) {
      data['categoryImage'] = image!.toJson();
    }
    return data;
  }
}

class CategoryImage {
  String? sType;
  String? name;
  String? url;

  CategoryImage({this.sType = 'File', this.name, this.url});

  CategoryImage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
