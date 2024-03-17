import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

class MChatMessage {

  int? id;
  String? text;
  String? image;
  String? video;
  String? recorder;
  String? status_read; // see class "EReadStatus" enum
  int? deleted;
  int? senderId;
  int? receiverId;
  String? groupKey;
  int? messageIdFollowed;
  int? reply;
  int? senderWaitId;
  int? createdAt;
  int? updatedAt;

  String? typeDateMessage; //when have value means it's date message like "Today, Yesterday"

  MChatMessage fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //Log.i( "MChatMessage - id: " + id.toString() );

    text = json['text'];
    image = json['image'];
    video = json['video'];
    recorder = json['recorder'];
    status_read = json['status_read'];
    // Log.i( "MChatMessage - status_read: " + status_read.toString() );

    deleted = json['deleted'];
   // Log.i( "MChatMessage - deleted: " + deleted.toString() );

    senderId = json['senderId'];
   // Log.i( "MChatMessage - senderId: " + senderId.toString() );

    receiverId = json['receiverId'];
    groupKey = json['group_key'];
    messageIdFollowed = json['messageIdFollowed'];
   // Log.i( "MChatMessage - messageIdFollowed: " + messageIdFollowed.toString() );

    reply = json['reply'];
 //   Log.i( "MChatMessage - reply: " + reply.toString() );

    senderWaitId = json[ 'sender_wait_id'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    return this;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['image'] = this.image;
    data['video'] = this.video;
    data['recorder'] = this.recorder;
    data['status_read'] = this.status_read;
    data['deleted'] = this.deleted;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['group_key'] = this.groupKey;
    data['messageIdFollowed'] = this.messageIdFollowed;
    data['reply'] = this.reply;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }


}
