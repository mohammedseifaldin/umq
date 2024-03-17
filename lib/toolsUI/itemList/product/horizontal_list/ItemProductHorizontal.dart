
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/data/source/CartCounterApi.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/modules/favorite/data/source/FavoriteTeacherApi.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/toolsUI/app_colors.dart';
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/toolsUI/itemList/product/horizontal_list/AddToCart.dart';
import 'package:umq/toolsUI/snack_bar.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

double _itemPhotoWidth = 200;
double _itemPhotoHeight = 170;

class ItemProductHorizontal extends StatelessWidget {

  MProduct mProduct;
  BuildContext pageContext;

  ItemProductHorizontal(this.pageContext, this.mProduct);


  @override
  Widget build(BuildContext context) {

    return itemProductHorizontal();
  }



  Widget itemProductHorizontal( ) {
    return GestureDetector( child:  showIntemContent( ),
        onTap: (){
          GoTo.productDetail_byId(pageContext, mProduct.id??0);
        } );
  }


  Widget showIntemContent( ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          photoAndButtonAddToCardWithBoarder(),
          price_and_name(),
        ],
      ),
    );
  }


  Widget photoAndButtonAddToCardWithBoarder() {
    return  Container(
        width: _itemPhotoWidth ,
        height: _itemPhotoHeight,

          // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            border:
            Border.all(color: Color.fromARGB(255, 184, 195, 209)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [


             photo(),
              clickCartWidget()
            ],
          ));
  }


  Widget photo(){
    // var img =  Image.network(mProduct.image!);
    var img = ImageFastor(context: pageContext,
        urlAspectRation:mProduct.image! ,
        // colorBackground: HexColor(ColorProject.blueTransparent),
        width: _itemPhotoWidth,
        height: _itemPhotoHeight);

    return  Align(
        alignment: Alignment.center,
        child: img  );
  }


  Widget price_and_name() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tv_name(),
          SizedBox(
            height: 10,
          ),
           tv_priceProduct(),
        ],
      ),
    );
  }


  Widget tv_name() {
    return Text(
      MProductTools.getNameByLang(pageContext, mProduct),
      style: TextStyle(
          letterSpacing: 1.2,
          fontSize: 16,
          fontWeight: FontWeight.w800),
    );
  }

  Widget tv_priceProduct() {
    return Text(
      '${mProduct.price} S.R',
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w800),
    );
  }

  Widget icon_shopping() {
    return CircleAvatar(
        backgroundColor: whiteBlue,
        radius: 13,
        child: Icon(
          Icons.shopping_bag_outlined,
          size: 15,
          color: Color.fromARGB(255, 10, 67, 114),
        ));
  }



}
