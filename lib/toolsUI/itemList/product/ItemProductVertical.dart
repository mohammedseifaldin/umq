
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

class ItemProductVertical extends StatelessWidget {


  MProduct data;
  BuildContext pageContext;

  ItemProductVertical(this.pageContext, this.data);


  @override
  Widget build(BuildContext context) {

    var card = Card(child: itemProduct(),
      elevation: 10,
    );

    return Container(child: card,
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }


  Widget itemProduct() {
    return Container(
      // margin:const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.shade100,
      ),
      child: InkWell(
        child: Row(
          children: [

            im_photo(),

            const SizedBox(width: 10,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data.nameEn}", style: const TextStyle(
                    fontSize: 20
                ),),
                const SizedBox(height: 10,),
                Text(getDescription(data), style: const TextStyle(
                    fontSize: 16
                ),),
              ],), flex: 1,),
          ],
        ),
        onTap: () {
          GoTo.productDetail_byId(pageContext, data.id??0);
          // Tools.ShowSuccessMessage(context, 'Comming soon product');
        },
      ),
    );
  }


  Widget im_photo() {
    var img = ImageFastor( context: pageContext, width: 120, height: 120,
      // radius_bottomRight: 40,
      //   radius_topRight: 40,
      // colorBackground: Colors.grey.shade300,
      assetAspectRatio: DrawableProject.images("logo"),
      urlAspectRation: data.image,
    );

    var crop = CropTemplate.rounded(
        child: img, width: 120, height: 120, radius_all: 10);

    return crop;
  }

  String getDescription(MProduct data) {
    return MProductTools.getDescriptionByLang(pageContext, data);
  }

}