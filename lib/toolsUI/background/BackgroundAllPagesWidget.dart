import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

/**
 ------------------------- - how to use

    - must write inside stack

    return Stack( children: [
    BackgroundAllPagesWidget(child: columnButton())
    ] );

 */
class BackgroundAllPagesWidget extends StatelessWidget {
  final Widget child;
  double positionTopMargin = 0.0;

   BackgroundAllPagesWidget({
    Key? key,
    required this.child,
     double? positionTopMargin
  }) : super(key: key){
     positionTopMargin ??= 0;
     this.positionTopMargin = positionTopMargin;
   }

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: 0 + positionTopMargin,
      child: colorBackgroundView()
    );
  }

  Widget colorBackgroundView(){
    return Container( child:  cardShape(),
    color: const Color(0xFFefefef),
    );
  }

  Widget cardShape(){
    return Container(
      width: MediaQuery.of(context!).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: child,
    );
  }


}

