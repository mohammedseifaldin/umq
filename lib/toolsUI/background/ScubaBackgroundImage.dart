import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

class ScubaBackgroundImage extends StatelessWidget {
  const ScubaBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageFastor(
      width: double.infinity,
      height: double.infinity,
      context: context,
      assetBackground: DrawableProject.images_with_extension(
        DeviceTools.isPortrait(context)
            ? "background_auth.jpeg"
            : "background_auth_landscape.jpeg",
      ),
    );
  }
}
