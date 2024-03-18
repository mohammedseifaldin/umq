
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';
import 'package:umq/modules/subscribe/presentation/admin/user_detail/SubscribeUserByAdminPage.dart';
import 'package:umq/modules/subscribe/provider/SubscribeUserByAdminPage.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/toolsUI/admin/picker/button_picker_user/button_picker_user.dart';


extension ContentUserDetail on SubscribeUserByAdminState {


  //------------------------------------------------------------  select user 

  Widget buttonPickerUserWidget(){
    return ButtonPickerUserWidget( contextPage: context, select: (user ){
      request.userId = user.id.toString();
      request.userName = user.name.toString();
      request.userImage = user.photo.toString();
      request.userPhone = user.country.toString() + user.mobile.toString();
    } );
  }
  //------------------------------------------------------------  select package


  Widget selectPackage() {
    var row =  RowTemplate.scroll(contextPage!,  [
      tv_package(),
      sp_package_selectedNameColumn()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_package(){
    return TextTemplate.t( "Subscribe Package",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }

  Widget sp_package_selectedNameColumn(){
    return ColumnTemplate.t( children: [
      sp_package(),
      tv_package_previousSelected()
    ]);
  }


  Widget tv_package_previousSelected(){
    // Log.i( "tv_package_previousSelected() - package_selected_name: " + package_selected_name );
    return TextTemplate.t(
        request.packageName ,
        levelDS: LevelDS.l4,
        margin: EdgeInsets.only(top: DSDimen.space_level_4),
        color: HexColor( ColorProject.blue_fish_front )
    );
  }


  Widget sp_package(){

    //check before create view
    if( provider!.allSubscribePackage  ==  null ) {
      return EmptyView.zero();
    }
    if( provider!.allSubscribePackage!.data  ==  null ) {
      return EmptyView.zero();
    }

    var spin =  SpinnerView(

      childers: package_listWidget(),
      iconSize: 22,
      width_frame: AdminDSDimen.inputFiled_value_width - AdminDSDimen.spinnerTriangleWidth,
      height_frame: 35,
      onSelectPosition:    (p, isRemoveSelected ) {
        Log.i( "sp_package() -  position: " + p.toString() );

        if( isRemoveSelected ){
          request.packageId =  null ;
          return;
        }

        var m = provider!.allSubscribePackage!.data![p];
        request.packageId = m.id.toString();
        request.price = m.price.toString();
        request.packagePeriod = m.period.toString();
        request.packageAllowedProductNumers = m.allowedProductNumers.toString();
        request.packageAllowedChat = m.allowedChat.toString();
        request.packageName =  MSubscribePackage.getNameEnglishPlusArabic(m);
      },
      hintWidget: package_hint() ,
    );

    //decoration
    return Container( child: spin,
      decoration: BoarderHelper.box(),
    );
  }


  Widget package_hint(){
    return TextFastor( "select",
        width: AdminDSDimen.inputFiled_title_width,
        color: Colors.grey,
        fontSize: 15,
        fontFamily: FontProject.beach,
         padding: EdgeInsets.all( 5),
    );
  }


  List<Widget> package_listWidget() {
    List<Widget> listWidget = [];
    for ( MSubscribePackage m in provider!.allSubscribePackage!.data!   ) {
      listWidget.add( mapModelToWidgetItemSpinner(m) );
    }
    return listWidget;
  }

  Widget mapModelToWidgetItemSpinner(MSubscribePackage m ) {
    String name = MSubscribePackage.getNameByLang(contextPage!, m);
    return TextFastor( name,
        levelDS: LevelDS.l3,
        padding: EdgeInsets.only(top: 5, left: 5),
        color: DSColor.ds_textfield_text,
        fontFamily: FontProject.beach,
        fontSize: 15,
        width: AdminDSDimen.inputFiled_value_width - AdminDSDimen.spinnerTriangleWidth
    );
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
    if( provider!.subscribeUserByAdminProgressStatus ) {
      return ProgressCircleFastor();
    }
    return ButtonTemplate.t( "save", () async {
      FocusScope.of( contextPage!).unfocus();

      await provider!.createSubscribeUserByAdmin(context, request );
    },
        margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_1 )
    );
  }


}
