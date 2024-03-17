
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';

class ShareInformationHelper {

  static Future shareProduct(BuildContext context, MProduct m ) async {
    String info = getProductInformation(context, m);
    String link = choosePlatformOfLink();
    await shareButton( "Scuba", info, link);
  }

  //-------------------------------------------------------------------- share function

  static Future<void> shareButton( String title, String txt , String url) async {
    await FlutterShare.share(
        title: title,
        text: txt,
        linkUrl: url,
        chooserTitle: 'Choose'
    );
  }

  //-------------------------------------------------------------------------- data

  static String getProductInformation(BuildContext context, MProduct m ) {
    String productName = MProductTools.getNameByLang(context, m);
    String des = MProductTools.getDescriptionByLang(context, m);
    return productName + "\n\n" + des;
  }


  static String choosePlatformOfLink() {
    //mobile anddroid or parseAndPush
    return "https://play.google.com/store/apps/details?id=com.scubaksa.scuba";
  }



}