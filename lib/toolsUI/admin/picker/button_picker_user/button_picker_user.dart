import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';

class ButtonPickerUserWidget extends StatefulWidget {

  ValueChanged<MUser> select;
  BuildContext contextPage;
  String userNameSelected = "";

  ButtonPickerUserWidget( {
    required this.contextPage,
    required this.select
  });

  @override
  _ButtonPickerUserState createState() {
    return _ButtonPickerUserState();
  }
}
class _ButtonPickerUserState extends State<ButtonPickerUserWidget> {



  @override
  Widget build(BuildContext context) {

    var row =  RowTemplate.scroll(context,  [
      tv_title(),
      spinnerShapeWithClickOnTouch()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_title(){
    return TextTemplate.t( "Select User",
        width: AdminDSDimen.inputFiled_title_width,

        levelDS: LevelDS.l2);
  }


  Widget spinnerShapeWithClickOnTouch(){
    var stack =  Stack( children: [
      chooseHintWidgetOrSelectedNameWidget(),
      Positioned(child: spinnerIcon(), right: 0  )
    ]);

    return GestureDetector(
      child: stack,
      onTap: (){
        pickerUserDialogOpen();
      },
    );
  }


  Widget spinnerIcon(){
    return Icon( Icons.arrow_drop_down , size: 21, color: Colors.black );
  }


  Widget chooseHintWidgetOrSelectedNameWidget(){
    if(ToolsValidation.isEmpty( widget.userNameSelected) ) {
      return hintWidget();
    } else {
      return selectedTextWidget();
    }
  }


  Widget selectedTextWidget(){
    return TextFastor( widget.userNameSelected,
        width: AdminDSDimen.inputFiled_value_width,
        decoration: BoarderHelper.box(),
        color: Colors.black,
        fontSize: 15,
        fontFamily: FontProject.beach,
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding)
    );
  }

  Widget hintWidget(){

    return TextFastor( "select user",
        width: AdminDSDimen.inputFiled_value_width,
        color: Colors.grey,
        fontFamily: FontProject.beach,
        fontSize: 15,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding)
    );
  }


  Future pickerUserDialogOpen() async {
    GoToAdmin.pickerUser( widget.contextPage, null,  select: ( MUser mUser) {
      Log.i( "pickerUserDialogOpen() - mUser " + mUser.toString() );


      setState(() {
        widget.userNameSelected = mUser.name!;
      });
      widget.select( mUser);
    });
  }

}