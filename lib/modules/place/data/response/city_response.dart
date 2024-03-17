

import 'package:umq/modules/place/data/model/MCity.dart';

class CityListResponse {
  bool status;
  List<MCity> data;

  CityListResponse(
      this.status,
      this.data,
      );

  CityListResponse.fromJson(Map<String, dynamic> json)
      : status = json["status"]=='success',
        data = json['data']['data'].map<MCity>((value) => MCity().fromJson(value)).toList();

  Map<String, dynamic> toJson() => {
        'success': status,
      };
}
