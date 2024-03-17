
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';


import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';

import 'package:umq/modules/subscribe/presentation/admin/package_detail/SubscribePackageDetailAdminPage.dart';
import 'package:umq/modules/subscribe/provider/SubscribePackageCreatePage.dart';


extension ContentUserDetail on SubscribePackageDetailAdminState {


  //---------------------------------------------------------------------- name en

  Widget name_en() {
    var row =  RowTemplate.scroll(contextPage!,  [
      _tv_nameEn(),
      _tf_nameEn()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget _tv_nameEn(){
    return TextTemplate.t( "name en",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget _tf_nameEn(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: widget.mEdit != null ? widget.mEdit!.nameEn??"" : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => request.nameEn = value
    );
  }

  //---------------------------------------------------------------------- name ar

  Widget name_ar() {
    var row =  RowTemplate.scroll(contextPage!,  [
      _tv_nameAr(),
      _tf_nameAr()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget _tv_nameAr(){
    return TextTemplate.t( "name ar",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget _tf_nameAr(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: widget.mEdit != null ? widget.mEdit!.nameAr??"" : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => request.nameAr = value
    );
  }


  //---------------------------------------------------------------------- desc en

  Widget desc_en() {
    var row =  RowTemplate.scroll(contextPage!,  [
      _tv_descEn(),
      _tf_descEn()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget _tv_descEn(){
    return TextTemplate.t( "description en",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget _tf_descEn(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: widget.mEdit != null ? widget.mEdit!.descriptionEn??"" : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => request.descriptionEn = value
    );
  }

  //---------------------------------------------------------------------- desc ar

  Widget desc_ar() {
    var row =  RowTemplate.scroll(contextPage!,  [
      _tv_descAr(),
      _tf_descAr()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget _tv_descAr(){
    return TextTemplate.t( "description ar",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget _tf_descAr(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: widget.mEdit != null ? widget.mEdit!.descriptionAr??"" : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => request.descriptionAr = value
    );
  }

  //---------------------------------------------------------------------- price

  Widget price() {
    var row =  RowTemplate.scroll(contextPage!,  [
      _tv_price(),
      _tf_price()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget _tv_price(){
    return TextTemplate.t( "Price / USD",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget _tf_price(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: widget.mEdit != null ? widget.mEdit!.price.toString()??"" : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validatorCustom: ValidatorTemplate.d( ),
        keyboardType: TextInputType.number,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) {
          try{
            request.price = int.parse( value );
          } catch( e) {
          }
        }
    );
  }

  //---------------------------------------------------------------------- period

  Widget period() {
    var row =  RowTemplate.scroll(contextPage!,  [
      _tv_period(),
      _tf_period()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget _tv_period(){
    return TextTemplate.t( "Period / Day",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget _tf_period(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: widget.mEdit != null ? widget.mEdit!.period.toString()??"" : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validatorCustom: ValidatorTemplate.d( ),
        keyboardType: TextInputType.number,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) {
          try{
            request.period = int.parse( value );
          } catch( e) {
          }
        }
    );
  }

  //---------------------------------------------------------------------- price

  Widget product_numbers() {
    var row =  RowTemplate.scroll(contextPage!,  [
      _tv_product_numbers(),
      _tf_product_numbers()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget _tv_product_numbers(){
    return TextTemplate.t( "Allowed Product Number",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget _tf_product_numbers(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: widget.mEdit != null ? widget.mEdit!.price.toString()??"" : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validatorCustom: ValidatorTemplate.d( ),
        keyboardType: TextInputType.number,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) {
          try{
            request.allowedProductNumbers = int.parse( value );
          } catch( e) {
          }
        }
    );
  }


  //---------------------------------------------------------------------- price

  Widget allow_chat() {
    var row =  RowTemplate.scroll(contextPage!,  [
      _tv_allow_chat(),
      _switch_allow_chat()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget _tv_allow_chat(){
    return TextTemplate.t( "Allowed Client Chat",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget _switch_allow_chat(){

    return SwitchFastor(defaultValue: request.allowedChat??true,
        onChange: (updateStatus){
          Log.i( "_switch_allow_chat() updateStatus: $updateStatus");
          request.allowedChat = updateStatus;
        });
  }


  //------------------------------------------------------------ save

  Widget save() {
    return  Container(
      child: _saveButton() ,
      margin: EdgeInsets.all(50),
      width: DeviceTools.getWidth(context),
      alignment: Alignment.center,
    );
  }


  Widget _saveButton() {
    if( provider!.createPackageProgressStatus ) {
      return ProgressCircleFastor();
    }
    return ButtonTemplate.t( "save", () async {
      FocusScope.of( contextPage!).unfocus();

      await provider!.createOrEditPackage(context, request );
    },
        margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_1 )
    );
  }


}
