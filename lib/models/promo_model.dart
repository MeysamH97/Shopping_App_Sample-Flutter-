class Promo {
  int? discountPercent;

  Promo({this.discountPercent});

  Promo.fromJson(Map<String, dynamic> json) {
    discountPercent = json['discount_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount_percent'] = discountPercent;
    return data;
  }
}