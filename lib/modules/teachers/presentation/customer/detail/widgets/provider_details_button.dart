import 'package:flutter/material.dart';

class ProviderDetailsButton extends StatefulWidget {
  void Function() buttonFn;
  String title;
  ProviderDetailsButton({Key? key, required this.buttonFn, required this.title})
      : super(key: key);

  @override
  State<ProviderDetailsButton> createState() => _ProviderDetailsButtonState();
}

class _ProviderDetailsButtonState extends State<ProviderDetailsButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: widget.buttonFn,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 10, 50, 109),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
