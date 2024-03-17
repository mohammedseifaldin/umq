import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

class ProviderRoundedImage extends StatelessWidget {
  const ProviderRoundedImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(100),
          topEnd: Radius.circular(100),
        ),
        child: imageUrl.isEmpty
            ? placeHolderImageViewWhenEmptyUrl()
            : imageViewDownloadByUrl2(context, imageUrl));
  }

  Widget imageViewDownloadByUrl2(context, String imageUrl) {
    return ImageFastor(
      context: context,
      width: 150,
      height: 150,
      assetAspectRatio: DrawableProject.placeholderImage,
      urlBackground: imageUrl,
      onPressed: () {
        Log.i("click on image view open provider");
        // GoTo.providerDetail(widget.pageContext, widget.provider);
      },
    );
  }

  Widget placeHolderImageViewWhenEmptyUrl() {
    Log.i("placeHolderImageView_when_emptyUrl()");
    return Container(
      width: 150.0,
      height: 150.0,
      color: Colors.grey[400],
      child: Image.asset(DrawableProject.placeholderImage.assetName),
    );
  }
}
