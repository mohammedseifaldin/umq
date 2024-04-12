import 'package:flutter/material.dart';

Widget noData() {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: textInCenter(),
  );
}

Widget textInCenter() {
  return const Center(
      child: Text(
    'No Data Found',
    style: TextStyle(
      fontSize: 18,
    ),
  ));
}
