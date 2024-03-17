import 'package:flutter/material.dart';
import 'package:umq/toolsUI/ThemeColor.dart';

class LoginInputWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isPassword;
  final bool enabled;
  final TextInputType inputType;
  late final Color color;
  final Widget? suffix;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  LoginInputWidget(
    this.title, {
    super.key,
    required this.controller,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    Color? color,
    this.suffix,
    this.enabled = true,
    this.onChanged,
    this.prefixIcon,
  }) {
    this.color = color ?? ThemeColor.colorSecoundry.withOpacity(.5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(50),
        color: color,
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: tfPhone(),
    );
  }

  Widget tfPhone() {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      onChanged: onChanged,
      style: TextStyle(fontFamily: 'Schyler', color: ThemeColor.colorInputText),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        border: InputBorder.none,
        filled: true,
        hintText: title,
        suffix: suffix,
        enabled: enabled,
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(
          color: Colors.grey.shade300,
          decoration: TextDecoration.none,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return '$title is empty';
        }
        return null;
      },
    );
  }
}
