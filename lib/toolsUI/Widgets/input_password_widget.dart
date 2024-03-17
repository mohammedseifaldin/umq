import 'package:flutter/material.dart';

import 'package:umq/toolsUI/ThemeColor.dart';
class InputPasswordWidget extends StatefulWidget {
  String title;
  var controller;

  @override
  _PageState createState() => _PageState();

  InputPasswordWidget(this.title, {this.controller});
}
class _PageState extends State<InputPasswordWidget> {
bool _obscureText = true;
void _toggle() {
  setState(() {
    _obscureText = !_obscureText;
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              controller: widget.controller!=null?widget.controller:TextEditingController(),
              obscureText: _obscureText,
              style: TextStyle(
                fontFamily:'Schyler',
                color: Colors.white
              ),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                border: InputBorder.none,
                filled: true,
                hintText: widget.title,
                hintStyle: TextStyle(
                  fontFamily:'Schyler',
                  color: Colors.grey.shade300,
                  decoration: TextDecoration.none,
              ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
                validator : (text) {
                  if (text == null || text.isEmpty) {
                    return '${widget.title} is empty';
                  }
                  return null;
                }
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: ThemeColor.colorSecoundry.withOpacity(.5),
              border: Border.all(color: Colors.white,width: 0.5)
            ),
          );
  }
}