import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

class ProviderImage extends StatelessWidget {
  const ProviderImage({super.key, required this.size, required this.url});
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10), child: cropCircleImage());
  }

  Widget cropCircleImage() {
    var cropChildToRadius = Material(
      clipBehavior: Clip.antiAlias, //here clicp
      shape: const CircleBorder(), //here set shpae of clip
      child: SizedBox(
        height: size,
        width: size,
        child: chooseTypeHaveUrl(),
      ),
    );

    return cropChildToRadius;
  }

  Widget chooseTypeHaveUrl() {
    if (ToolsValidation.isMoreThan2(url)) {
      return getImageDownloadByUrl();
    } else {
      return placeHolderImageProvider();
    }
  }

  Widget placeHolderImageProvider() {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(2),
      // shape: CircleBorder(),
      child: SizedBox(
          height: size,
          width: size,
          //  padding: EdgeInsets.all(5),
          child: Image.asset(DrawableProject.placeholderImage.assetName)),
    );
  }

  Widget getImageDownloadByUrl() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: SizedBox(
          height: size,
          width: size,
          //  padding: EdgeInsets.all(5),
          child: imageNetwordView()),
    );
  }

  Widget imageNetwordView() {
    return Image.network(
      "$url",
      fit: BoxFit.cover,
      errorBuilder: (contex, c, e) {
        return Image.asset("assets/images/logo.png");
      },
    );
  }
}
