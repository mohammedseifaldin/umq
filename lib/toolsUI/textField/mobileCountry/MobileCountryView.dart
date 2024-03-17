import 'package:country_code_picker/country_code_picker.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';


import 'package:fastor_app_ui_widget/resource/template/column/ColumnTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/row/RowTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';

import 'package:fastor_app_ui_widget/resource/template/textfield/validator/ValidatorTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';



class MobileCountryView extends StatefulWidget {

  ValueChanged<MobileCountryViewState> callBackState;
  Decoration? decoration;

  MobileCountryView(this.callBackState, {
    Decoration? decoration
  }) {
    this.decoration = decoration;
  }

  @override
  MobileCountryViewState createState() {
    var state =  MobileCountryViewState(decoration: decoration);
    callBackState(state);
    return state;
  }

}
class MobileCountryViewState extends State<MobileCountryView> {

  //---------------------------------------------------------------- variable
  //info
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController phone_controller = TextEditingController();


  //backend
  var countryCode_text = "";//+20
  var phone_text = "";


  Decoration? decoration;

  //constructor
  MobileCountryViewState( {
    Decoration? decoration
  }) {
    this.decoration = decoration;
  }


  //---------------------------------------------------------------- public

  void setAutoValidteModeAlways(){
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
  }

  //--------------------------------------------------------------- life cycle

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCountryCodeCurrent();
  }


  void setCountryCodeCurrent() {
    ZoneTools.getZoneCountryDialCode("+966").then((value)   {
       //Log.i( "MobileVerificationController - setCurrentCountryDial() - value: " + value );

      setState(() {
        countryCode_text = value;

        //check test emulator
        /**
         * the emulator country is "+1" america
         */
        if( EnvironmentConstant.isTest ) {
          countryCode_text = "+20";
        }
      //  Log.i( "setCountryCodeCurrent() - countryCode_text: " + countryCode_text );
      });


    });
  }

  //---------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    debugMode();
      return mobile();
  }


  Widget mobile(){
    return ColumnTemplate.t( children: [
      tx_mobile(),
      countryWithPhone()
    ],
    );
  }

  //---------------------------------------------------------------------- debug

  void debugMode() {
    if (EnvironmentConstant.isLive ) return;
    // phone_controller.text = "01012345601";
    // phone_text = "01012345601";
  }

  //----------------------------------------------------------------------- stack

  Widget countryWithPhone(){
    var row =  RowTemplate.child1_WrapWidth_child2_expanded( country(), tf_phone(),
        gravityLayout: Alignment.bottomLeft );

    return Container( child:  row ,
        margin: EdgeInsets.only(top: DSDimen.space_level_3 ),
    decoration: decoration );
    // return tf_phone();
  }


  Widget tx_mobile() {
    return TextTemplate.t( "Mobile",
      levelDS: LevelDS.l2,
      margin: EdgeInsets.only(top: DSDimen.space_level_2   )
    );
  }

//----------------------------------------------------------------------- country

  Widget country(){
    var country =  CountryCodePicker(
        onChanged: (countryCode) {
        // Log.i( "c: " + countryCode.toString() );
          countryCode_text = countryCode.dialCode!;
        },
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: countryCode_text,
        favorite: [ "+966",  "+20"],
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,

      //remove default padding
        padding: EdgeInsets.zero
    );
    
    var scale = Transform.scale(scale: 1, child:  country );

    return Container( child:  scale,

    );
    // return SizedBox( width: 100, height: DesignSystemDimen.ds_text_level_2, child: Container(
    //   color: Colors.green,
    //   child:  scale,
    //   alignment: Alignment.topLeft,
    // )
    // );
  }

  //----------------------------------------------------------------------- textfield



  Widget tf_phone(){
  //  Log.i( "_MobileCountryState - tf_phone() ");
    return TextFieldTemplate.t(
      // background_color: Colors.red,
      margin: EdgeInsets.only(left: DSDimen.space_level_3, top:  8),
      controller: phone_controller,
        validator: ValidatorTemplate.mobile( ),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        autovalidateMode: autovalidateMode,
        keyboardType: TextInputType.phone,
   //     hint_text: "ex: 01012345678" ,
        onChanged: (phone){
          phone_text = phone;
        });
  }


}