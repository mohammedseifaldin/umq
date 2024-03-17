
class MImageGallery {
  int? id;
  int? providerId;
  String? file;
  int? hidden;
  int? published;
  int? createdAt;
  int? updatedAt;
  int? favorite;
  int? userId;



  MImageGallery.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    //  Log.i( "ImageGallery - id: " + id.toString() );

    providerId = json['provider_id'];


    file = json['file'];
    hidden = json['hidden'];
    //  Log.i( "ImageGallery - hidden: " + hidden.toString() );

    published = json['published'];
    //  Log.i( "ImageGallery - published: " + published.toString() );

    createdAt = json['created_at'];
    //  Log.i( "ImageGallery - createdAt: " + createdAt.toString() );

    updatedAt = json['updated_at'];

    favorite = json['favorite'];
    //  Log.i( "ImageGallery - favorite: " + favorite.toString() );

    userId = json['user_id'];
    // Log.i( "ImageGallery - userId: " + userId.toString() );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['file'] = this.file;
    data['hidden'] = this.hidden;
    data['published'] = this.published;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['favorite'] = this.favorite;
    data['user_id'] = this.userId;

    return data;
  }

  @override
  String toString() {
    return 'ImageGallery{id: $id, favorite: $favorite}';
  }
}