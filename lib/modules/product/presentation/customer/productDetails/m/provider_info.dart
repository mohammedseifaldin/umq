class ProviderInfo {
  String? whats;
  ProviderInfo.fromJson(Map<String, dynamic> json) {
    whats = json['whats'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['whats'] =  whats;
    return data;
  }
}
