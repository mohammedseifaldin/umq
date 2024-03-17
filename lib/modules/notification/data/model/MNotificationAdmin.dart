import 'package:umq/modules/profile/data/model/m_user.dart';

class MNotificationAdmin {
  int? id;
  String? topic;
  String? fcmMessageId;
  String? title;
  String? message;
  int? fcmStatus;
  int? created;
  int? updated;
  MUser? userTarget;

  MNotificationAdmin(
      {this.id,
      this.topic,
      this.fcmMessageId,
      this.title,
      this.message,
      this.fcmStatus,
      this.created,
      this.updated});

  MNotificationAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    fcmMessageId = json['fcm_message_id'];
    title = json['title'];
    message = json['message'];
    fcmStatus = json['fcm_status'];
    created = json['created'];
    updated = json['updated'];
    userTarget = json['user_target'] != null
        ? MUser.fromJson(json['user_target'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['fcm_message_id'] = this.fcmMessageId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['fcm_status'] = this.fcmStatus;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
