

import 'package:umq/modules/profile/data/model/MOrganization.dart';

class OrganizationResponse {
  bool status;
  List<MOrganization> data;

  OrganizationResponse(
      this.status,
      this.data,
      );

  OrganizationResponse.fromJson(Map<String, dynamic> json)
      : status = json["status"]=='success',
        data = json['data']['data'].map<MOrganization>((value) => MOrganization.fromJson(value)).toList();

  Map<String, dynamic> toJson() => {
        'success': status,
      };
}

