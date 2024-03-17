
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/c/ProductDetailController.dart';
import 'package:umq/toolsUI/buttons/BlueBlurButtonScuba.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';



import 'package:url_launcher/url_launcher.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/view/ProductDetailView.dart';

import 'package:umq/modules/product/presentation/customer/productDetails/view/ProductDetailView.dart';

extension  ContactWidget on ProductDetailState {


  Widget getContactWidget( ) {
    return  selectedProduct == null
          ? const CircularProgressIndicator()
          : showRow();
    }

  Widget showRow() {
    return Stack(
      children: [

        EmptyView.empty( DeviceTools.getWidth(context), 50 ),

        //bt contact
        Positioned( child: bt_contact_seller(),
        left: 10, ),

        //call and whats
        Positioned(child: im_phoneView(), right: 10 ,  top: 0, bottom: 0),
        Positioned(child: im_whatsView(), right: 90 ,  top: 0, bottom: 0),

      ],
    );
  }

  Widget bt_contact_seller() {

    String title =   'Contact Trainer';
    return BlueBlurButtonScuba(title, 180, 50, (){
      Log.i( "bt_contact_seller() - selectedProduct: " + selectedProduct!.toString() );
      Log.i( "bt_contact_seller() - .: " + selectedProduct!.provider!.toString() );

      String phone = selectedProduct!.provider!.whats??"";
      Log.i( "bt_contact_seller() - whats: " + phone );

      if( ToolsValidation.isPhoneMobileValid( phone ) ) {
        
        openCallDirectly('${selectedProduct!.provider_mobile}');
      } else {
        ToolsToast.i(context,  "Phone not found");
      }

    });
  // return ButtonTemplate.t( "contact trainer", () {
    //
    //   launchCall('${selectedProduct!.provider!.whats}');
    // },
    // width: 220,
    //   height: 60,
    //     margin: EdgeInsets.only(left: 10),
    //   textColor:Colors.blue.shade900,
    //   decoration: BoarderHelper.rounded(
    //       radiusSize: 30,
    //       colorBackground: Color(0xFF04026e)
    //   )
    // );

    // return Container(
    //     margin: EdgeInsets.only(left: 8, right: 8),
    // height: 60,
    // width: 100,
    // decoration: BoxDecoration(
    // color: Color(0xFF04026e),
    // borderRadius: BorderRadius.circular(30)),
    // child: Center(
    // child: ,
    // )
    // );
  }



  Widget im_whatsView() {
    return CircleAvatar(
      child: im_whats_asset(),
      radius: 25,
      backgroundColor: Colors.blue[300],
    );
  }

  Widget im_whats_asset() {
    //Image.asset('assets/images/whatsapp.png')
    return ImageView(width: 50, height: 50,
      assetAspectRatio: DrawableProject.images( "whatsapp"),
      padding: EdgeInsets.all(10),
      onPressed: (){
        openwhatsapp('${selectedProduct!.provider_mobile}');
      },
    );
  }

  Widget im_phoneView() {

    var click =  GestureDetector(
      onTap: () {
        //        launchCall(
        //             '${selectedProduct!.provider_mobile!}');
        openCallDirectly( selectedProduct!.provider_mobile! );
      },
      child: iconCall(),
    );

    var avatar = CircleAvatar(
      child: click,
      backgroundColor: Colors.blue[300],
      radius: 25,
    );

    return avatar;
  }

  Widget iconCall() {
    var icon = Icon(
      Icons.call,
      size: 30,
      color: Colors.blue.shade900,
    );

    return Material( child:  icon, color: Colors.transparent, );
  }




}
