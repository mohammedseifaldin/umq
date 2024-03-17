import 'package:flutter/material.dart';

class InformationBackWidget extends StatelessWidget {
  final Widget widget;

  const InformationBackWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFe4f5fe),
      ),
      child: widget,
    );
  }
}
