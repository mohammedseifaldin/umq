import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/data/model/MCartSingleProduct.dart';
import 'package:umq/modules/cart/presentation/customer/main/c/MainCartController.dart';
import 'package:umq/modules/cart/presentation/customer/main/c/itemProduct/ItemProductCartController.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/MainCartPage.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/views/itemProduct/v/RowPlusMinsCart.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/values/ToolsPrice.dart';
import 'package:umq/toolsUI/favorite/FavoriteButton.dart';

class ItemProductCartView extends StatefulWidget {
  static double frame_height = 150;
  double frame_width_image = 120;

  MainCartState parentState;
  MCartSingleProduct mCart;
  int position;

  ItemProductCartView(this.parentState, this.mCart, this.position);

  @override
  ItemProductCartState createState() {
    return ItemProductCartState();
  }
}

class ItemProductCartState extends State<ItemProductCartView> {
  //--------------------------------------------------------------------- variable

  bool progressPlusMines = false;
  int counterCurrent = 0;
  int isFavorite = 0;

  //--------------------------------------------------------------------- life cycle

  @override
  void initState() {
    super.initState();
    //set when first time show cart item
    counterCurrent = widget.mCart.counter!;
    isFavorite = widget.mCart.product!.favorite!;
  }

  //--------------------------------------------------------------------- build ui

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getCartContent(),
      decoration: BoarderHelper.cardView(),
      margin: EdgeInsets.only(
          left: DSDimen.space_level_2,
          right: DSDimen.space_level_2,
          top: DSDimen.space_level_3),
    );
  }

  Widget _getCartContent() {
    return Stack(
      children: [
        //empty
        EmptyView.empty(DeviceTools.getWidth(widget.parentState.context),
            ItemProductCartView.frame_height),

        //image
        image(),

        //cancel
        cancel(),

        //favorite
        Positioned(child: bt_favorite(), right: 0),

        //column
        Positioned(
            child: productInfoAndPlusMinus(),
            left: widget.frame_width_image + DSDimen.space_level_3)
      ],
    );
  }

  //---------------------------------------------------------------- row top: image, cancel, favorite

  Widget cancel() {
    var im = ImageViewTemplate(
      context: widget.parentState.context,
      widthNeeded: 50,
      heightNeeded: 50,
      radius_all: 25,
      //  colorBackground: HexColor( ColorProject.blue_fish_front),
      padding: EdgeInsets.all(15),
      onPressed: () async {
        await widget.parentState.cancelClick(widget.mCart);
      },
      assetAspectRatio: DrawableProject.images("cancel"),
    );

    return Container(
      child: im,
      margin: EdgeInsets.only(
          top: DSDimen.space_level_2, left: DSDimen.space_level_2),
    );
  }

  Widget image() {
    //info
    var size = widget.frame_width_image;
    String imageUrl = widget.mCart.product!.image!;

    //image
    var img = ImageViewTemplate(
      context: context,
      widthNeeded: size,
      heightNeeded: size,
      onPressed: () {
        int id = widget.mCart.product!.id!;
        GoTo.productDetail_byId(context, id);
      },
      assetAspectRatio: DrawableProject.images("logo"),
      urlAspectRation: imageUrl,
    );

    //circle
    var crop = CropTemplate.rounded(
        child: img, width: size, height: size, radius_all: 10);

    //margin
    return Container(
      child: crop,
      margin: EdgeInsets.only(
          left: DSDimen.space_level_2,
          top: DSDimen.space_level_2,
          bottom: DSDimen.space_level_2),
    );
  }

  Widget bt_favorite() {
    var bt = FavoriteButton(
      favorite: isFavorite,
      backgroundColor: HexColor(ColorProject.white_sun_2),
      onTap: () async {
        await favoriteClick(widget.mCart);
      },
    );

    return Container(
      child: bt,
      margin: EdgeInsets.only(
          top: DSDimen.space_level_2, right: DSDimen.space_level_2),
    );
  }

  //---------------------------------------------------------------- column info

  Widget productInfoAndPlusMinus() {
    return ColumnTemplate.t(
        padding: EdgeInsets.all(DSDimen.space_level_2),
        children: [
          tvName(),
          tvPrice(),
          EmptyView.empty(5, DSDimen.text_level_2),
          rowPlusMines()
        ]);
  }

  Widget tvName() {
    String name = MProductTools.getNameByLang(context, widget.mCart.product);
    return TextTemplate.t(
      name,
      levelDS: LevelDS.l2,
    );
  }

  Widget tvPrice() {
    //values
    var v = widget.mCart.product!.price!;
    String price = ToolsPrice.prefix(v);

    //tv
    return TextTemplate.t(price,
        margin: EdgeInsets.only(top: DSDimen.space_level_2),
        color: HexColor(ColorProject.blue_fish_front),
        // fontFamily: FontProject.beach,
        levelDS: LevelDS.l2);
  }
}
