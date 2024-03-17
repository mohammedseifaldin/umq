import 'package:flutter/material.dart';

import 'package:umq/toolsUI/ThemeColor.dart';

typedef callback = Function(dynamic val);

class DropdownWidget extends StatelessWidget {
  callback? onChanged;
  List<String> items = [];
  String? selectedValue;

  DropdownWidget(this.items, {this.onChanged, this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child:DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue == null ? items[0] : selectedValue!,
          isExpanded: true,
          dropdownColor: Colors.white,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
              ),),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          color: ThemeColor.colorSecoundry.withOpacity(.5),
          border: Border.all(color: Colors.white,width: 0.5)
      ),
    );
  }
}
