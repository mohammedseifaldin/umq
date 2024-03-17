import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:umq/toolsUI/ThemeColor.dart';
class LoadingWidget extends StatelessWidget {
  double height=20;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding:const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade600, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 5,
            )
          ]),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade500,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(color: Colors.grey,height: height,),flex: 1,),
                Expanded(child: Container(color: Colors.grey,height: height,), flex: 3,)
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(color: Colors.grey,height: height,),flex: 1,),
                Expanded(child: Container(color: Colors.grey,height: height,), flex: 3,)
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(color: Colors.grey,height: height,),flex: 1,),
                Expanded(child: Container(color: Colors.grey,height: height,), flex: 3,)
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(color: Colors.grey,height: height,),flex: 1,),
                Expanded(child: Container(color: Colors.grey,height: height,), flex: 3,)
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(color: Colors.grey,height: height,),flex: 1,),
                Expanded(child: Container(color: Colors.grey,height: height,), flex: 3,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}