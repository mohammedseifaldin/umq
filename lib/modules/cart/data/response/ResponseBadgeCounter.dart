class ResponseBadgeCounter {
  String? status;
  int? code;
  int? badgeCounter;

  ResponseBadgeCounter({this.status, this.code, this.badgeCounter});

  ResponseBadgeCounter.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    badgeCounter = json['badge_counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['badge_counter'] = this.badgeCounter;
    return data;
  }
}
