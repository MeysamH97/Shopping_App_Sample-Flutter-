class User {
  String? username;
  String? email;
  String? name;
  String? phone;
  String? address;
  String? imageAddress;
  String? objectId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.username,
      this.email,
      this.name,
      this.phone,
      this.address,
      this.imageAddress,
      this.objectId,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    imageAddress = json['imageAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['imageAddress'] = imageAddress;

    return data;
  }
}
