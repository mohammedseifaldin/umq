class MSettingAdmin {

  // String? aboutUs;
  // String? terms;
  String? status;
  int? code;
  String? aboutUs;
  String? terms;

  MSettingAdmin({this.status, this.code, this.aboutUs, this.terms});

  MSettingAdmin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    aboutUs = json['about_us'];
    terms = json['terms'];
  }

}