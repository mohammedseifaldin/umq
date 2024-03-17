import 'package:flutter/material.dart';

Widget noData() {
  return Container( child:  textInCenter() ,
  margin: EdgeInsets.only(top: 20),);
}

Widget textInCenter() {
  return Center(
      child: Text(
        'No Data Found',
        style: TextStyle(
          fontSize: 18,
        ),
      ));
}