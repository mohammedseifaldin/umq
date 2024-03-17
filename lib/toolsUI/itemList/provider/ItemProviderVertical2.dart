
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/Widgets/widget_image.dart';

class ItemProviderVertical2 extends StatelessWidget {

  MProvider data;
  BuildContext pageContext;
  ItemProviderVertical2( this.pageContext, this.data );


  @override
  Widget build(BuildContext context) {

    return contentProvider();
  }


  Widget contentProvider( ){
    return Container(
        margin:const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius:const BorderRadius.all(Radius.circular(20)),
          color: Colors.grey.shade100,
        ),
        child: InkWell(
          child: Row(
            children: [
              ProviderImage(url: data.users!.photo,size: 100 ),
              const SizedBox(width: 10,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${data.users!.name ?? "NA" }",style:const TextStyle(
                      fontSize: 18
                  ),),
                  const SizedBox(height: 10,),

                  /**
                   role keyword in english forever come from api :
                      "Student" or "Provider"
                   */
                  Text("${data.users!.role!  }",style:const TextStyle(
                      fontSize: 16
                  ),),
                ],),flex: 1,),
            ],
          ),
          onTap: (){
            GoTo.providerDetail(  pageContext ,  data);
            //Tools.ShowSuccessMessage(context, 'Comming soon provider');
          },
        )
    );
  }



}