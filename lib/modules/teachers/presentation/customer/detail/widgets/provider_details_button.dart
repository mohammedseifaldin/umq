import 'package:flutter/material.dart';

class ProviderDetailsButton extends StatefulWidget {
  void Function() buttonFn;
  String title;
  ProviderDetailsButton(
      {super.key, required this.buttonFn, required this.title});

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
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 10, 50, 109),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
