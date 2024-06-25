class promotion_slider {
  late String id;
  late String url;
  promotion_slider({required this.id, required this.url});

  promotion_slider.fromJson(Map<String,dynamic> json){
    id = json['objectId'];
    url = json['image']['url'];
  }
}