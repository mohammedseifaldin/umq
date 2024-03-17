
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/c/ClickActionsUserDetails.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/c/EditUserController.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/v/UserDetailAdminPage.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/attachCapture/capture/CaptureTools.dart';
import 'package:umq/toolsUI/textfield/mobileCountry/MobileCountryView.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ContentUserDetail on UserDetailAdminState {


  //---------------------------------------------------------------------- name

  Widget name() {
    var row =  RowTemplate.scroll(contextPage!,  [
      tv_name(),
      tf_name()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_name(){
    return TextTemplate.t( "name",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget tf_name(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: getEditName(),
        autovalidateMode: name_valid,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => name_txt = value
    );
  }


  //---------------------------------------------------------------------- name

  Widget email() {
    var row =  RowTemplate.scroll(contextPage!,  [
      tv_email(),
      tf_email()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_email(){
    return TextTemplate.t( "email",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget tf_email(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: getEditEmail(),
        autovalidateMode: email_valid,
        validatorCustom: ValidatorTemplate.email( ),
        keyboardType: TextInputType.emailAddress,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => email_txt = value
    );
  }

  //----------------------------------------------------------- password

  Widget password() {
    var row =  RowTemplate.scroll(contextPage!,  [
      tv_password(),
      tf_password()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_password(){
    return TextTemplate.t( "password",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget tf_password(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: "********",
        autovalidateMode: password_valid,
        validatorCustom: ValidatorTemplate.pass( ),
        keyboardType: TextInputType.visiblePassword,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => password_txt = value
    );
  }

  //------------------------------------------------------------------- city

  Widget city() {
    var row =  RowTemplate.scroll(contextPage!,  [
      tv_city(),
      sp_city_selectedNameColumn()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_city(){
    return TextTemplate.t( "city",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }

  Widget sp_city_selectedNameColumn(){
    return ColumnTemplate.t( children: [
      sp_city(),
      tv_city_previousSelected()
    ]);
  }


  Widget tv_city_previousSelected(){
   // Log.i( "tv_city_previousSelected() - city_selected_name: " + city_selected_name );
    return TextTemplate.t(
        city_selected_name ,
      levelDS: LevelDS.l4,
      margin: EdgeInsets.only(top: DSDimen.space_level_4),
      color: HexColor( ColorProject.blue_fish_front )
    );
  }


  Widget sp_city(){

    //check before create view
    if( UserDetailAdminState.city_list.length == 0 ) {
      return EmptyView.zero();
    }

    var spin =  SpinnerView(

        childers: city_listWidget(),
        iconSize: 22,
        width_frame: AdminDSDimen.inputFiled_value_width - AdminDSDimen.spinnerTriangleWidth,
        height_frame: 35,
        onSelectPosition:    (p, isRemoveSelected ) {
          Log.i( "sp_city() -  position: " + p.toString() );

          if( isRemoveSelected ){
            city_selected_name =  "";
            return;
          }

          var m = UserDetailAdminState.city_list[p];
          city_selected_name = MCityTools.getNameByLang(contextPage!, m);
          city_selected_id = m.id!;

        },
      hintWidget: city_hint() ,
    );

    //decoration
    return Container( child: spin,
    decoration: BoarderHelper.box(),
    );
  }

  Widget city_hint(){
    return  TextTemplate.t( "select city",
        padding: EdgeInsets.all( 5),
        levelDS: LevelDS.l2);
  }


  List<Widget> city_listWidget() {
    List<Widget> listWidget = [];
    for ( MCity m in UserDetailAdminState.city_list   ) {
      String name = MCityTools.getNameByLang(contextPage!, m);
      Widget w = TextTemplate.t( name,
          levelDS: LevelDS.l3,
          padding: EdgeInsets.only(top: 5, left: 5),
          color: DSColor.ds_textfield_text,
          width: AdminDSDimen.inputFiled_value_width - AdminDSDimen.spinnerTriangleWidth
      );
      listWidget.add( w );
    }
    return listWidget;
  }

  //-------------------------------------------------------------------- mobile

  Widget mobile() {
    //check edit not have mobile
    /**
     the mobile is primary can not be edit
     */
    if( mEdit != null ) {
      return EmptyView.zero();
    }

    //return view
    var v = MobileCountryView( (state) {
      mobileState = state;
    },
      decoration: BoarderHelper.box()
    );

    //fix landscape
    var sizeBox = SizedBox(
        width: AdminDSDimen.inputFiled_line,
        child: v
    );

    return Container(
      child: sizeBox,

      margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1),
    );
  }

  //------------------------------------------------------------------- photo

  Widget photo(){
    return ColumnTemplate.t( children: [
      tv_photo(),
      im_photo()
    ],
      margin: EdgeInsets.only(left: DSDimen.space_level_2)
    );
  }


  Widget tv_photo() {
    return TextTemplate.t( "photo",
        levelDS: LevelDS.l2,
        margin: EdgeInsets.only(top: DSDimen.space_level_2)
    );
  }

  Widget im_photo(){
    var im = photo_image();

    var cont =  Container(
      child:  im,
      width: AdminDSDimen.inputFiled_value_width ,
      height: AdminDSDimen.inputFiled_value_width ,
      // color: Colors.red,
      margin: EdgeInsets.only(top:   DSDimen.space_level_3 ),
      padding: EdgeInsets.all( 3 ),
      decoration: BoarderHelper.box(
          colorLine: DSColor.table_row_boader //color of admin table boarder
      ),
    );

    return cont;
  }


  Widget photo_image() {

    var im =  ImageView(
        width: AdminDSDimen.inputFiled_value_width,
        height: AdminDSDimen.inputFiled_value_width,
        assetAspectRatio: DrawableProject.placeholderImage,
        urlBackground: photo_url_selected,
        onChangeState: (value) {
          photo_state = value;
        // Log.i( "photo_image() - photo_state "   + photo_state!.toString( ));
        }, onPressed: () async {
        await photo_click();
      },
    );

    return Stack(children: [
      im,
      photo_progress()
    ],);
  }


  Widget photo_progress(){
    if(photo_progress_status == false ) {
      return EmptyView.zero();
    }

    return ProgressSpinkit.get();
  }

  //------------------------------------------------------------ save

  Widget save(){
    var bt = ButtonTemplate.t( "save", () async {
      await save_click();
    },
    margin: EdgeInsets.only(top: DSDimen.space_level_2 + 2 ,
    bottom: DSDimen.space_level_1 )
    );

    return Container( child: bt,
    alignment: Alignment.center,
    );
  }




}