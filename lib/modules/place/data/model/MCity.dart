
class MCity {
  int? id;
  String? name_ar;
  String? name_en;


  MCity fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name_ar = json["name_ar"];
    name_en = json["name_en"];
    return this;
  }


  @override
  String toString() {
    return 'MCity{id: $id, name_ar: $name_ar, name_en: $name_en}';
  }

  MCity.constructor(this.id, this.name_ar, this.name_en);

  MCity();
}
