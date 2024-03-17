class Category {
  String? name_en;
  Category.fromJson(Map<String, dynamic> json) {
    name_en = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name_en'] = this.name_en;
    return data;
  }
}
