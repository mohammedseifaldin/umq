
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/c/ProductDetailController.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/view/ProductDetailView.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/DimenProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/share/ShareInformationHelper.dart';
import 'package:umq/toolsUI/favorite/FavoriteButton.dart';


extension ShowImage on ProductDetailState {

  //-------------------------------------------------------------------- card

  Widget getShowImage() {

    return selectedProduct == null
          ? const CircularProgressIndicator()
          : cardViewImage();

  }


  Widget cardViewImage() {
    var cont = Container(
      height: 200,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(right: DimenProject.radiusScaffoldCorner/2, left: DimenProject.radiusScaffoldCorner/2, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,// HexColor(ColorProject.white_oxygen),
          borderRadius: BorderRadius.circular( DimenProject.radiusScaffoldCorner)),
      child: stackImageWithButtons(),
    );

    var card =  Card(
        child:  cont,
        // shadowColor:  FD.cardview_shadow,
        elevation : 5
    );
    return card;
  }


  Widget stackImageWithButtons() {
    return Stack( children: [

      EmptyView.empty(DeviceTools.getWidth(context), 200),
      imagePhoto(),
      Positioned(child:  columnButton(), right: 0)

    ],);
  }

  //-------------------------------------------------------------------- image

  Widget imagePhoto() {
    return ImageView(width: DeviceTools.getWidth(context), height: 200,
    assetAspectRatio: DrawableProject.placeholderImage,
      urlBackground: selectedProduct!.image! ,
      onPressed: (){
      String imageUrl = selectedProduct!.image!;
      GoTo.fullScreenImage(context, imageUrl);
      },
    );
  }

  //-------------------------------------------------------------------- buttons

  Widget columnButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [


        bt_favorite(),
        const SizedBox(
          height: 15,
        ),

        bt_share()
      ],
    );
  }


  Widget bt_share(){
    var click =  InkWell(
      onTap: () async {
        await ShareInformationHelper.shareProduct( context, selectedProduct! );
      },
      child: const Icon(
        Icons.share,
        color: Colors.blue,
        size: 35,
      ),
    );

    return Material( child:  click ,);
  }

  Widget bt_favorite() {
    return FavoriteButton(
      favorite: selectedProduct!.favorite!,
      backgroundColor: Colors.white,
      onTap: () async {
       await changeFavoriteStatus( );
      },
    );
  }


}
