class ImageModel {
  String? link;
  String? path;

  ImageModel({
    this.link,
    this.path,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['link'] = link;
    json['path'] = path;

    return json;
  }
}
