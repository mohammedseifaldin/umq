
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/view/ProductDetailView.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

extension  InfoProduct on ProductDetailState {



  Widget getInfoProduct( ) {
    return  selectedProduct == null
          ? const CircularProgressIndicator()
          : showInfo();
  }

  Widget showInfo() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      // height: 110,
      decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(25)),
      child: columnInfo(),
    );
  }

  Widget columnInfo() {
    return Column(
      children: [


        barNameAndRate(),

        SizedBox(
          height: 5,
        ),

        lineSepartor(),



      rowPrice()


      ],
    );
  }

  Widget barNameAndRate() {
    return Stack( children: [

          EmptyView.empty( DeviceTools.getWidth(context), 25 ),

          Positioned(child: tv_productName() , left: 0 ),

          Positioned(child: rateRow() , right: 0 )

        ],

      ) ;
  }


  Widget tv_productName() {
    return  TextTemplate.t(
      MProductTools.generateNameAndRentText( context, selectedProduct!),
      levelDS: LevelDS.l2,
      color: HexColor( ColorProject.black_1 )
    );
  }


  Widget rateRow(){
    return Row(
      children: [
        tv_rateValue(),
        rateIcon(),

      ],
    );
  }


  Widget rateIcon() {
    var icon =  Icon(
      Icons.star,
      color: Colors.yellow[600],
    );

    return Material( child:  icon , color: Colors.transparent,);
  }


  Widget lineSepartor() {
    return Container(
      height: 3,
      color: Colors.blue[200],
    );
  }


  Widget rowPrice() {
    return    Stack(
      children: [
        EmptyView.empty( DeviceTools.getWidth(context), 25 ),

        tv_price_title(),
        Positioned(child:  tv_price_value(), right: 0 )

      ],
    );
  }


  Widget tv_rateValue() {
    return TextTemplate.t('${selectedProduct!.rate}',
        textAlign: TextAlign.start,
        padding: EdgeInsets.only(right: DSDimen.space_level_3 ),
        levelDS: LevelDS.l2);
  }

  Widget tv_price_title() {
  //  return Text('price');
    return TextTemplate.t( 'price',
        padding: EdgeInsets.only(top: 10),
    levelDS: LevelDS.l2
    );
  }

  Widget tv_price_value() {
    return TextTemplate.t( "${selectedProduct!.price} S.R.",
    padding: EdgeInsets.only(top: 10),
    levelDS: LevelDS.l2
    );
  }





}
