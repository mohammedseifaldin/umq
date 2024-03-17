class EditProfileRequest {
  EditProfileRequest({
    required this.name,
    required this.email,
    required this.cityId,
    required this.photo,
  });

  String name;
  String email;
  String cityId;
  String photo;

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "city_id": cityId,
        "photo": photo,
      };
}
