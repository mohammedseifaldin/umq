
class MVideoGallery {
  int? id;
  int? providerId;
  String? file;
  String? thump;
  int? hidden;
  int? published;
  int? createdAt;
  int? updatedAt;
  int? favorite;
  int? userId;



  MVideoGallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    file = json['file'];
    thump = json['thump'];
    hidden = json['hidden'];
    published = json['published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    favorite = json['favorite'];
    userId = json['user_id'];
    // Log.i( "VideoGallery - userId: " + userId.toString() );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['file'] = this.file;
    data['thump'] = this.thump;
    data['hidden'] = this.hidden;
    data['published'] = this.published;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['favorite'] = this.favorite;
    data['user_id'] = this.userId;

    return data;
  }
}
