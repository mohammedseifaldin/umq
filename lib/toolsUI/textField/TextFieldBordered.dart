import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';

class TextFieldBordered extends StatelessWidget {

  final TextEditingController controller;
  final String hint;
  final Widget prefix;
  final TextInputType type;

  const TextFieldBordered({
    Key? key,
    required this.controller,
    required this.hint,
    required this.prefix,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

     //margin
     // margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: getTextField(),
    );
  }

  Widget getTextField() {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      style:  TextStyle( color: DSColor.ds_textfield_text,
          fontFamily: FontProject.beach,
          fontSize: DSDimen.text_level_2 ),
      decoration: getInputDecoration(),
    );
  }


  InputDecoration getInputDecoration() {
    return InputDecoration(

      /**
       * fix the "city picker" dropdown view same height
       */
      contentPadding: EdgeInsets.symmetric(vertical: 22),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( DSDimen.ds_size_corner_level_2 ),
        borderSide:   BorderSide(
          width: 1.1,
          color:  DSColor.ds_textfield_boarder_line,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( DSDimen.ds_size_corner_level_2 ),
        borderSide:   BorderSide(
          color: DSColor.ds_textfield_boarder_line,
          width: 1.0,
        ),
      ),
      hintText: hint,
      prefixIcon: prefix,
    );
  }


}
