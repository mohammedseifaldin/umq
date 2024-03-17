import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';

@Deprecated( "not used")
class ImageViewPlaceholder extends StatelessWidget {

  String url ;
  String placeHolderAssetName;

  ImageViewPlaceholder(this.url, this.placeHolderAssetName);

  @override
  Widget build(BuildContext context) {
    return ImageView( width: 150, height: 150,);
  }
}