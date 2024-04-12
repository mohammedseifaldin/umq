import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

/**
------------- exmple of on use of favroite button

    Future changeFaviorteStatus() async {

    //check login
    if( await UserSingleTone.instance().isGuest() ) {
    CheckoutLoginDialog.show(context);
    return;
    }

    //change to
    var changeStatusTo = ToolsAPI.changeStatus( selectedProduct!.favorite!);
    setState(() {
    selectedProduct!.favorite = changeStatusTo;
    });

    ResponseGeneral response = await ApiHelper.apiHelper.favoriteApi( selectedProduct!.id!, changeStatusTo);

    Log.i("changeFaviorteStatus() - response: " + response.toString() );

    if( ToolsAPI.isFailed( response.code)) {
    setState(() {
    var original = ToolsAPI.changeStatus( selectedProduct!.favorite!);
    selectedProduct!.favorite = original;
    });
    }


    }

 */
class FavoriteButton extends StatelessWidget {
  GestureTapCallback onTap;
  int favorite;
  Color backgroundColor;

  FavoriteButton(
      {super.key,
      required this.favorite,
      required this.backgroundColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return bt_favorite();
  }

  Widget bt_favorite() {
    var click = GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.favorite_sharp,
        color: favorite == 1
            ? HexColor(ColorProject.blue_fish_front)
            : HexColor(ColorProject.greyDark),
        size: 35,
      ),
    );

    var cont = Container(
      color: backgroundColor,
      child: click,
    );
    return Material(child: cont);
  }
}
