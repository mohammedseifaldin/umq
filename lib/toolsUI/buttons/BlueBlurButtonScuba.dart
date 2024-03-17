
import 'package:flutter/material.dart';
import 'package:umq/toolsUI/ThemeColor.dart';

class BlueBlurButtonScuba extends StatelessWidget {

  String title;
  double width;
  double height;
  GestureTapCallback onTapCallback;

  BlueBlurButtonScuba(this.title, this.width, this.height, this.onTapCallback);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(child: containerAddToBasket(),
      onTap: onTapCallback,
    );
  }

  Widget containerAddToBasket() {
    return Container(
      //margin: EdgeInsets.only(left: 8, right: 15),
      width: width, //220
      height: height, //60
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5,0.7],
            colors: [
              ThemeColor.hexToColor('#05A8F1'),
              ThemeColor.hexToColor('#005190'),
              ThemeColor.hexToColor('#09265F'),
            ],
          ),
          // gradient: const LinearGradient(
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight,
          //     colors: [
          //       Color(0xFF0D47A1),
          //       Color(0xFFBBDEFB),
          //     ]),
          // color: Colors.blue[900],
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          title,
        //  'Add to Basket',
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 18),
        ),
      ),
    );
  }


}