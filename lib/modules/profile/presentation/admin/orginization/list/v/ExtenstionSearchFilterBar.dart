
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/list/c/SearchDownloadController.dart';
import 'package:umq/tools/resourceProject/DrawableAdmin.dart';

import 'OrgListAdminPage.dart';


@Deprecated( "not used until today")
extension ExtenstionSearchFilterBar on OrgListAdminState {

  //---------------------------------------------------------------------- build

  Widget barFilterAndSearchView() {
    var row =  RowTemplate.scroll( context, [
         //bt_test(),
     bt_refresh(),
     // speartor(),
      // stackSearchBar(),
      // speartor(),
      // spinner_role()  //role

    ] );

    return Container(
      child: row,
      // color: DSColor.menu_background,
      alignment: Alignment.centerLeft,
     // padding: EdgeInsets.only(top : DSDimen.space_level_2 ),
      margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 ),
    );
  }


  Widget speartor() {
    var line =  EmptyView.colored( 1, DSDimen.text_level_1, DSColor.separatorLine_backgroundWhite );

    return Container(
      child: line,
      margin: EdgeInsets.symmetric(horizontal: DSDimen.text_level_2),
    );
  }

  //------------------------------------------------------------------------- button test

  Widget bt_test(){

    return ButtonFastor(  'Test' , ()    {


    });
  }

//------------------------------------------------------------------------- refresh

  Widget bt_refresh() {
    var margin  = EdgeInsets.only(
        top: DSDimen.space_level_2,
        // left: DSDimen.space_level_1 ,
        // right: DSDimen.space_level_3,
        bottom:  DSDimen.space_level_2);
    return ButtonTemplate.t( "Refresh", () {
      refreshFunction(isResetPage: false );
    },
      levelDS: LevelDS.l2,
    margin: margin,
    );
  }

  //------------------------------------------------------------------- search

  Widget stackSearchBar(){
    var stack =  Stack( children: [
      searchByWord(),
      Positioned(child: searchIcon(), right: 10 , top: 4 , bottom: 0 )

    ],);

    return Container( child: stack,
    decoration: BoarderHelper.box(),
    );
  }

//flutter navigate swift kotlin java

  Widget searchByWord() {


    //return
    return TextFieldFastor(
      controller: search_controller,
      hint_text: "Name | Mobile",
      // text_color: DSColor.spinner_hint,
      padding: EdgeInsets.only(left: 13, top: 13, bottom: 13, right: 40 ),
      // margin: EdgeInsets.only(right: DSDimen.ds_space_to_level_3),
      fontSize: DSDimen.text_level_3,
      onChanged: (s){
        search_txt = s;
        },
        width: 250,
    );
  }


  Widget searchIcon(){

    var image = ImageView(width: 35, height: 35,
      assetBackground: DrawableAdmin.icon_search,
      responsive_auto : false,
      padding: EdgeInsets.all(5),
      onPressed: (){

      searchTextClick();

      },
    ) ;
    return image;
  }



}
