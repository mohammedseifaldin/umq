
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/product/data/model/MCategory.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';


class MProvider {
  int? id;
  int? userId;
  String? whats;
  int? cityId;
  int? orgId;
  int? block;
  int? hidden;
  String? locationName;
  String? lat;
  String? lng;
  int? createdAt;
  int? updatedAt;
  String? rate;
  int? favorite;
  MUser? users;
  MCity? city;
  MOrganization? organization;

  @override
  String toString() {
    return 'MProvider{id: $id, userId: $userId, whats: $whats, cityId: $cityId, orgId: $orgId, block: $block, hidden: $hidden, locationName: $locationName, lat: $lat, lng: $lng, createdAt: $createdAt, updatedAt: $updatedAt, rate: $rate, favorite: $favorite, users: $users, city: $city, organization: $organization}';
  }

  MProvider fromJson(Map<String, dynamic> json) {

    id = json['id'];
  // Log.i( "MProvider - fromJson() - id: " + id.toString() );

    userId = json['user_id'];
   // Log.i( "MProvider - fromJson() - userId: " + userId.toString() );

    whats = json['whats'];
    cityId = json['city_id'];
    orgId = json['org_id'];
   // Log.i( "MProvider - fromJson() - orgId: " + orgId.toString() );

    block = json['block'];
    hidden = json['hidden'];
    locationName = json['location_name'];
    //Log.i( "MProvider - fromJson() - locationName: " + locationName.toString() );

    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  // Log.i( "MProvider - fromJson() - updatedAt: " + updatedAt.toString() );

    //fix double value sometimes return integer "0" without fraction
     rate = json['rate'].toString();
  //  double rate_double = double.parse(rate_str);
 // Log.i( "MProvider - fromJson() - rate: " + rate.toString() );

    favorite = json['favorite'];
   // Log.i( "MProvider - fromJson() - favorite: " + favorite.toString() );
    users = json['users'] != null ? MUser.fromJson(json['users']) : null;
   //Log.i( "MProvider - fromJson() - users: " + users.toString() );

    city = json['city'] != null ? MCity().fromJson(json['city']) : null;
   // Log.i( "MProvider - fromJson() - city: " + city.toString() );

    organization = json['organization'] != null
        ? MOrganization.fromJson(json['organization'])
        : null;

   // Log.i( "MProvider - fromJson() - organization: " + organization.toString() );
    return this;
  }

}