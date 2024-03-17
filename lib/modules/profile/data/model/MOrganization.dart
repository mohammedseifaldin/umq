
class MOrganization {
  int id;
  String name;

  MOrganization(
      this.id,
      this.name,
      );

  MOrganization.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];


}
