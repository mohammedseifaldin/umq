import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/toolsUI/app_colors.dart';

import 'package:umq/tools/map/ToolsMapIntent.dart';

import 'package:url_launcher/url_launcher.dart';


class ProviderInfoView extends StatefulWidget {
  MProvider user;
  ProviderInfoView({Key? key, required this.user}) : super(key: key);

  @override
  ProviderInfoState createState() => ProviderInfoState();
}

class ProviderInfoState extends State<ProviderInfoView> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceTools.getWidth(context),
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 220, 247, 248),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          infoRow(widget.user.users!.name??"NA", Icons.person, () {}),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: whiteBlue,
            thickness: 1.5,
          ),
          infoRow(widget.user.users!.email??"NA", Icons.mark_as_unread_sharp,
              () => launch('mailto:${widget.user.users!.email??"NA"}')),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: whiteBlue,
            thickness: 1.5,
          ),
          infoRow(widget.user.users!.mobile??"NA", Icons.phone,
              () => launch('tel://${widget.user.users!.mobile??"NA"}')),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: whiteBlue,
            thickness: 1.5,
          ),
          infoRow(
              widget.user.users!.country??"NA",
              Icons.location_on,
              () => ToolsMapIntent.openMap(double.parse(widget.user.lat ??""),
                  double.parse(widget.user.lat??""))),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }


  Widget infoRow(String text, IconData icon, function) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            function();
          },
          child: Row(
            children: [
              Icon(
                icon,
                color: whiteBlue,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                    color: darkBlue, fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
