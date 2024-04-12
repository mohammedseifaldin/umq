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

  BackgroundAllPagesWidget(
      {super.key, required this.child, double? positionTopMargin}) {
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
        child: colorBackgroundView());
  }

  Widget colorBackgroundView() {
    return Container(
      color: const Color(0xFFefefef),
      child: cardShape(),
    );
  }

  Widget cardShape() {
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
