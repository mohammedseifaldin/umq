import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product_detail/provider/contact_functions.dart';
import 'package:umq/modules/product_detail/provider/product_details_notifier.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/buttons/BlueBlurButtonScuba.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, required this.provider});

  final ProductDetailsNotifier provider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        EmptyView.empty(DeviceTools.getWidth(context), 50),

        Positioned(
          left: 10,
          child: contactSellerBtn(context),
        ),

        //call and whats
        Positioned(
          right: 10,
          top: 0,
          bottom: 0,
          child: CircleAvatar(
            backgroundColor: Colors.blue[300],
            radius: 25,
            child: GestureDetector(
              onTap: () {
                provider.openCallDirectly(provider.product!.provider.mobile);
              },
              child: Material(
                color: Colors.transparent,
                child: Icon(
                  Icons.call,
                  size: 30,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            right: 90,
            top: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue[300],
              child: ImageFastor(
                context: context,
                width: 50,
                height: 50,
                assetAspectRatio: DrawableProject.images("whatsapp"),
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  provider.openwhatsapp(provider.product!.provider.mobile);
                },
              ),
            )),
      ],
    );
  }

  Widget contactSellerBtn(context) {
    String title = 'Contact Provider';
    return BlueBlurButtonScuba(title, 180, 50, () {
      String phone = provider.product!.provider.mobile;
      if (ToolsValidation.isPhoneMobileValid(phone)) {
        provider.openCallDirectly(phone);
      } else {
        ToolsToast.i(context, "Phone not found");
      }
    });
  }
}
