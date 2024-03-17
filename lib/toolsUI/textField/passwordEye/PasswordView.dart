// 
// 
// import 'package:fastor_app_ui_widget/resource/template/column/ColumnTemplate.dart';
// import 'package:fastor_app_ui_widget/resource/template/row/RowTemplate.dart';
// import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';
// import 'package:fastor_app_ui_widget/resource/template/textfield/TextFieldTemplate.dart';
// import 'package:fastor_app_ui_widget/resource/template/textfield/validator/ValidatorTemplate.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:umq/tools/fastor/drawable/FastorDrawable.dart';
// import 'package:umq/tools/constant/EnvironmentConstant.dart';
// import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/fastor/drawable/FastorDrawable.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';

class PasswordView extends StatefulWidget {

  ValueChanged<String>? onChanged;
  ValueChanged<PasswordViewState> stateListener;
  LevelDS? levelDS;

  PasswordView(  this.stateListener, {
    ValueChanged<String>? this.onChanged,
    LevelDS? this.levelDS
  }  ) ;


  @override
  // ignore: no_logic_in_create_state
  PasswordViewState createState() {
    var state =  PasswordViewState( onChanged: onChanged , levelDS: levelDS  );
  //  Log.i( "PasswordView - createState() - state: " + state.toString() );
    stateListener(state);
    return state;
  }


}

class PasswordViewState extends State<PasswordView>{

  //---------------------------------------------------------------------- debug

  void debugMode() {
    if (EnvironmentConstant.isLive ) return;
    setState(() {
      pass_controller.text = "12345678";
      tf_pass_text = "12345678";
    });
  }

  //----------------------------------------------------------------------- variable and cosntructor

  var tf_pass_text = "";
  ValueChanged<String>? onChanged;
  var autovalidateMode = AutovalidateMode.disabled;
  var pass_controller = TextEditingController();

  LevelDS? levelDS;

  PasswordViewState({
    ValueChanged<String>? this.onChanged,
    LevelDS? this.levelDS
  } )  {

    levelDS ??= LevelDS.l2;
  }

  //----------------------------------------------------------------- public

  void setAutoValidteModeAlways(){
   // Log.i( "PasswordViewState - changeStateOusideClas()");

    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
  }

  //------------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    debugMode();
    return pass();
  }

  Widget pass(){
    return ColumnTemplate.t( children: [
      tx_pass(),
      passwordWithEye()

    ]);
  }


  //----------------------------------------------------------------------- textfield

  Widget tx_pass() {
    return TextTemplate.t( "Password", levelDS: levelDS!,
       margin: EdgeInsets.only(top: DSDimen.space_level_2)

    );
  }


  Widget passwordWithEye() {
    return RowTemplate.child1_expanded_child2_wrapWidth(tf_pass(), im_eye() );
  }

  Widget tf_pass() {
    // Log.i( "tf_pass() - tf_pass_text: " + tf_pass_text);
    // Log.i( "tf_pass() - tf_pass_textInputType: " + tf_pass_textInputType.toString() );

    return TextFieldTemplate.t(
      controller: pass_controller,
        validator: ValidatorTemplate.pass( ),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
     //   hint_text: "Password",
        margin: EdgeInsets.only(top: DSDimen.space_level_3),
        error_text: "missed pass",
        onChanged: (s){
          tf_pass_text = s;

          if(onChanged != null ) onChanged!(s);

        },
        autovalidateMode: autovalidateMode,
        keyboardType: tf_pass_textInputType
    );
  }


  //--------------------------------------------------------------------- eye password

  var im_eye_visiblity = false;
  var imageName =  FastorDrawable.eye_pasword_off;
  var tf_pass_textInputType = TextInputType.visiblePassword;

  Widget im_eye() {
    // Log.i( "click image - im_eye_visiblity: " + im_eye_visiblity.toString() );
    // Log.i( "click image - imageName: " + imageName.toString() );

    var image = Image(image: imageName, width: 25 , height: 19 );
    var containter = Container(
        child: image,
        margin: EdgeInsets.only(top: DSDimen.textfield_auto_padding*2),
        padding: EdgeInsets.all(5),  //padding here
        // margin: EdgeInsets.only( left: 20),

        //size + padding of click
        width: 25+5,
        height: 19+5

    );

    return GestureDetector(
      onTap: (){

        //convert current status
        im_eye_visiblity = !im_eye_visiblity;


        updateTypeOfEye();

        // backClick();
      },
      child: containter,
    );
  }

  void updateTypeOfEye() {
    if( im_eye_visiblity ) {
      eye_update_showPassword();
    } else {
      eye_update_hidePassword();
    }
  }


  void eye_update_hidePassword(){
    setState(() {
      imageName = FastorDrawable.eye_pasword_off;
      tf_pass_textInputType = TextInputType.visiblePassword;
    });
  }


  void eye_update_showPassword(){
    setState(() {
      imageName = FastorDrawable.eye_pasword_on;
      tf_pass_textInputType = TextInputType.text;
    });
  }



}