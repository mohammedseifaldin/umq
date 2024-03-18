

import 'package:umq/modules/teachers/data/model/MTeacher.dart';

class ResponseSearchProvider {

  List<MProvider>? data;
  int? currentPage;
  int? total;


  ResponseSearchProvider fromJson(Map<String, dynamic> json) {
    //Log.i( "ResponseSearchProvider - fromJson() - json: " + json.toString()  );
    if (json['data'] != null) {
      data = <MProvider>[];
      json['data'].forEach((v) {
       // Log.i( "ResponseSearchProvider - fromJson() - v: " + v.toString()  );
        var m =  MProvider().fromJson(v);
        //Log.i( "ResponseSearchProvider - fromJson() - m: " + m.toString()  );
        data!.add( m );
      });
    }
    currentPage = json['current_page'];
    total = json['total'];
    return this;
  }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   data['current_page'] = this.currentPage;
  //   data['total'] = this.totalBar;
  //   return data;
  // }
}


// class ResponseSearchProvider {
//   List<MProvider> data;
//
//   ResponseSearchProvider(
//       this.data,
//       );
//
//   ResponseSearchProvider.fromJson(Map<String, dynamic> json)
//       :data = json['data'].map<SearchData>((value) => MProvider.fromJson(value)).toList();
//
// }
//
//
// class SearchData {
//
//   dynamic id;
//   dynamic user_id;
//   dynamic location_name;
//   UserData users;
//   CityData city;
//   OrganizationData organization;
//
//   SearchData(
//       this.id,
//       this.user_id,
//       this.location_name,
//       this.users,
//       this.city,
//       this.organization,
//       );
//
//   SearchData.fromJson(Map<String, dynamic> json)
//       : id = json["id"],
//         user_id = json["user_id"],
//         location_name = json["location_name"]??"",
//         users = UserData.fromJson(json["users"]),
//   city = CityData.fromJson(json["city"]),
//         organization = OrganizationData.fromJson(json["organization"]);
//
//
// }
// class UserData {
//   dynamic id;
//   dynamic name;
//   dynamic photo;
//   dynamic email;
//   dynamic country;
//   dynamic mobile;
//   dynamic role;
//
//   UserData(
//       this.id,
//       this.name,
//       this.photo,
//       this.email,
//       this.country,
//       this.mobile,
//       this.role,
//       );
//
//   UserData.fromJson(Map<String, dynamic> json)
//       : id = json["id"],
//         name = json["name"],
//         photo = json["photo"]??"",
//         email = json["email"],
//         country = json["country"],
//         mobile = json["mobile"],
//         role = json["role"];
//
//
// }
//
