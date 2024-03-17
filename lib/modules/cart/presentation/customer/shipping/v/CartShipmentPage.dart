import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/cart/presentation/customer/shipping/c/CartShipmentController.dart';
import 'package:umq/modules/cart/presentation/customer/shipping/c/ShippmentInputFieldController.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/ToolbarCart/ToolbarCart.dart';
import 'package:umq/toolsUI/Widgets/login_input_widget.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';
import 'package:umq/toolsUI/buttons/BlueBlurButtonScuba.dart';
import 'package:umq/toolsUI/dropbox/dropdownCity/CityDropDownWidget.dart';

import 'package:umq/toolsUI/textField/TextFieldBordered.dart';
import 'package:umq/toolsUI/textField/TextFieldBorderedLong.dart';
import 'package:umq/toolsUI/toolbarBackButton/ToolbarProjectBack.dart';

class CartShipmentPage extends StatefulWidget {


  @override
  CartShipmentState createState() {
    return CartShipmentState();
  }

}

class CartShipmentState extends State<CartShipmentPage> {

  //---------------------------------------------------------------------- variable

  //address
  var address_txt = "";
  // var address_valid = AutovalidateMode.disabled;
  var address_con = TextEditingController( );

  //city
  List<MCity> listCity = [];
  String? citySelectedName ;
  MCity? citySelectedObject;
  CityDropDownWidget? cityWidget;

  //city
  String countryCode = "";

  //---------------------------------------------------------------------- life style

  @override
  void initState() {
    super.initState();
    getDownloadCity();
    setEditData();
  }

  //---------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {

    var listCart = OrderCurrentSingletone.instance().cartList;
    // Log.i( "CartShipmentPage - build() - listCart: " + listCart.toString() );

    return PageTemplate.t( this ,
      content: getContent(),

      resizeToAvoidBottomInset: true,
      //toolbar
      toolbar: toolbar(),
      toolbar_height: ToolbarCartView.frameHeight,

    );
  }

  Widget toolbar(){
    return ToolbarCartView(  context, "Shipment", 1 ,
        onBackClick: ( b ){


          //must to return to main cart or home page
          /**
           * fix: case open many pages above each other of tabs
           *  (shipment, payment, receipt)
           */
          GoTo.homeStudent(context);
        }
    );
  }

  //------------------------------------------------------------------ content

  Widget getContent() {
    return ColumnTemplate.t(
      margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_2 ),
        width: DeviceTools.getWidth(context),
        alignGravity: Alignment.topCenter  ,
        children: [
          tvTitle(),
          addressDetailTv(),
          cityDropdown(),
          //countryDropdown()
          btNext()
        ]);
  }


  Widget tvTitle() {
    return TextTemplate.t( "Enter your Location",
    gravityLayoutAlign: Alignment.center,
    levelDS: LevelDS.l2);
  }



  Widget addressDetailTv(){

    var iconPrefix =  Icon(
          Icons.location_city_outlined,
          color: DSColor.ds_textfield_hint,
        );

    var tf =  TextFieldFastor(
        controller: address_con,
        // autovalidateMode: address_valid,
        textAlign: TextAlign.start,
        hint_text: "Address",
        isShowBoarder : true,
        minLines: 4,
        maxLines: 4,
        prefixIcon: iconPrefix,
        margin: EdgeInsets.only(top: DSDimen.space_level_3),
        validatorCustom: ValidatorTemplate.email( ),
        keyboardType: TextInputType.emailAddress,
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (s) async {
          address_txt = s;
        //save data
        OrderCurrentSingletone.instance().address = address_txt;
        }
      // margin: EdgeInsets.only( top: DesignSystemDimen.ds_space_to_level_2)
    );

    //margin
    return Container( child:  tf ,
      margin: EdgeInsets.only( top: DSDimen.space_level_2 ));
  }


  Widget cityDropdown() {
    cityWidget = CityDropDownWidget(
      items:  listCity,
      selectedValue: citySelectedName ,
      onTap: (data, cityName) {

        //save data
        OrderCurrentSingletone.instance().city = data;

        setState(() {
          citySelectedObject = data;
          citySelectedName = cityName;
        });
      },
    );

    return Container( child:  cityWidget,
        margin:  EdgeInsets.only( top: DSDimen.space_level_3)
    );
  }

  Widget btNext(){

    String title =   'Next';
    var bt =  BlueBlurButtonScuba(title, DeviceTools.getWidth(context), 50, () async {
      await clickNext();

    } );

    return Container( child: bt,
        margin: EdgeInsets.only(top: DSDimen.space_level_1 ,
          bottom: DSDimen.space_level_1,
        )
    );
  }


}