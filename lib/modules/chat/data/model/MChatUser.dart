import 'package:umq/modules/profile/data/model/m_user.dart';

import 'MChatMessage.dart';

class MChatUser {
  int? id;
  int? personA;
  int? personB;
  String? groupKey;
  String? groupType;
  int? lastMessageTime;
  int? blockerPersonA;
  int? blockerPersonB;
  int? blockerAdmin;
  MChatMessage? lastMessage; // = new MChatMessage();
  // MChatUserInfo? user ;//= new MChatUserInfo();
  MUser? user;
  int? counterNotRead;

  MChatUser fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //Log.i( "MChatUser - id: " + id.toString() );

    personA = json['person_a'];
    personB = json['person_b'];
    groupKey = json['group_key'];
    groupType = json['group_type'];
    lastMessageTime = json['lastMessageTime'];
    blockerPersonA = json['blocker_person_a'];
    blockerPersonB = json['blocker_person_b'];
    blockerAdmin = json['blocker_admin'];
    //Log.i( "MChatUser - blockerAdmin: " + blockerAdmin.toString() );

    //lastMessage
    if (json['last_message'] != null) {
      lastMessage = new MChatMessage().fromJson(json['last_message']);
      // Log.i( "MChatUser - lastMessage: " + lastMessage.toString() );
    }

    // user
    if (json['user'] != null) {
      user = MUser.fromJson(json['user']);
    }
    // Log.i( "MChatUser - user: " + user.toString() );

    counterNotRead = json['counter_not_read'];
    // Log.i( "MChatUser - counterNotRead: " + counterNotRead.toString() );

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['person_a'] = this.personA;
    data['person_b'] = this.personB;
    data['group_key'] = this.groupKey;
    data['group_type'] = this.groupType;
    data['lastMessageTime'] = this.lastMessageTime;
    data['blocker_person_a'] = this.blockerPersonA;
    data['blocker_person_b'] = this.blockerPersonB;
    data['blocker_admin'] = this.blockerAdmin;
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    // if (this.user != null) {
    //   data['user'] = new MUser().toJson();
    // }
    data['counter_not_read'] = this.counterNotRead;
    return data;
  }
}
