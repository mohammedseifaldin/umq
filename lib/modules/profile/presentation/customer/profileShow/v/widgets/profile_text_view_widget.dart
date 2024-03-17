import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTextViewWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool k;

  const ProfileTextViewWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.k,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Icon(
                icon,
                color: DSColor.ds_textfield_text,
              ),
              const SizedBox(
                width: 8,
              ),
                titleTv(),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          !k
              ? Container()
              : const SizedBox(
                  height: 16,
                ),
          !k
              ? Container()
              : Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: DSColor.ds_textfield_text,
                )
        ],
      ),
    );
  }

  Widget titleTv() {
    //  Text(title),
    return TextTemplate.t( title , levelDS: LevelDS.l2);
  }
}
