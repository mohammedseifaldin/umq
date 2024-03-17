import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/Widgets/provider_rounded_image.dart';

import '../../rating_stars.dart';

class ItemProviderHomeVertical extends StatefulWidget {
  MProvider provider;
  BuildContext pageContext;

  ItemProviderHomeVertical(this.pageContext, {Key? key, required this.provider})
      : super(key: key);

  @override
  State<ItemProviderHomeVertical> createState() =>
      _ItemProviderHomeVerticalState();
}

class _ItemProviderHomeVerticalState extends State<ItemProviderHomeVertical> {
  @override
  Widget build(BuildContext context) {
    return itemFrame();
  }

  Widget itemFrame() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      //  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: GestureDetector(
          child: shadowItem(),
          onTap: () {
            GoTo.providerDetail(widget.pageContext, widget.provider);
          }),
    );
  }

  Widget shadowItem() {
    var elevationValue = 10.0;

    var shadow = PhysicalModel(
      elevation: elevationValue,
      color: Colors.transparent,
      child: itemContent(),
    );

    return Container(
      padding: EdgeInsets.all(elevationValue),
      child: shadow,
    );
  }

  Widget itemContent() {
    return Container(
      height: 150,
      decoration: containerDecoration(),
      //,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProviderRoundedImage(imageUrl: widget.provider.users?.photo ?? ""),
          const SizedBox(width: 15),
          providerDataColumn()
        ],
      ),
    );
  }

  BoxDecoration containerDecoration() {
    return const BoxDecoration(
        color: Color.fromARGB(255, 235, 233, 233),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(10),
          left: Radius.circular(10),
        ));
  }

  Widget providerDataColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        nameTv(),
        const SizedBox(
          height: 25,
        ),
        countryTv(),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RatingStars(widget.provider.rate.toString(), 20.0, onChanged: (v) {
              Log.i("click on rate open provider");
              GoTo.providerDetail(context, widget.provider);
            })
          ],
        )
      ],
    );
  }

  Widget nameTv() {
    String s = widget.provider.users?.name ?? "NA";
    return TextTemplate.t(s, levelDS: LevelDS.l2);
  }

  Widget countryTv() {
    //String s =    widget.provider.users!.name??"NA";
    String s = MCityTools.getNameByLang(context, widget.provider.city);
    return TextTemplate.t(s, levelDS: LevelDS.l2);
  }

}
