class RequestSubscribePackageHide {

  int packageId = 0 ;
  int hidden = 1; //to hide send in request "1"

  RequestSubscribePackageHide({required this.packageId, required this.hidden});

  RequestSubscribePackageHide.fromJson(Map<String, dynamic> json) {
    hidden = json['hidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hidden'] = this.hidden;
    return data;
  }
}
