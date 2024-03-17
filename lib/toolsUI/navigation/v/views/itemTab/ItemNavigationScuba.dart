import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/toolsUI/navigation/m/EnumNavigationPage.dart';
import 'package:umq/toolsUI/navigation/m/ModelNavigation.dart';
import 'package:umq/toolsUI/navigation/v/NavigationScuba.dart';
import 'package:umq/toolsUI/navigation/v/views/itemTab/IconBadge.dart';

double _sizeIcon = 15;

class ItemNavigationScuba extends StatelessWidget {

  BuildContext contextPage;
  double sizeTab;
  EnumNavigationPage   currentEnumNavigationPage;

  ModelNavigation model;


  ItemNavigationScuba( {
    required this.contextPage,
    required this.sizeTab,
    required this.model,
    required this.currentEnumNavigationPage
});

  @override
  Widget build(BuildContext context) {

    return GestureDetector( child:  getContentTabUI() ,
        onTap: () {
      clickOnPosition(  );
    });
  }

  //------------------------------------------------------------- click


  void clickOnPosition(  ){
    Log.i( "clickOnPosition() - model: " + model.title  );

    //click on same position
    if( currentEnumNavigationPage ==  model.enumNavigationPage ) return;

    //navigate
    NavigationTools.pushAndRemoveUntilAnimateFade(  contextPage, model.goToPage );

  }

  //-------------------------------------------------------------- content ui

  Widget getContentTabUI(  ) {
      return ColumnTemplate.t(
        width:  sizeTab,
        //  height: ToolbarCartView.frameHeight_rowTabsChoose,
        colorBackground: Colors.transparent,
        //  decoration: getBoarder(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          ///space top
          EmptyView.empty( 0,  DSDimen.space_level_4 /2),

          ///icons
          chooseTypeIconWithBadgeOrJustIcon(),

          /// title
          EmptyView.empty( 0,  DSDimen.space_level_4 /2 ),
          _titleTv( ),

          ///space down
          EmptyView.empty( 0,  DSDimen.space_level_4 /2 ),
          separatorLineColorSelectedOrNot( )
        ]);
  }

  //---------------------------------------------------------------- icon

  Widget chooseTypeIconWithBadgeOrJustIcon() {
    if( model.badgeCounter == 0 ) {
      return _iconImage();
    }

    return badgeWithIcon();
  }

  Widget _iconImage(  ) {
    return Icon(
      model.iconData,
      size:  _sizeIcon,
      color: getColorSelectedOrNot(  ),
    );
  }

  Widget badgeWithIcon(){
    // return Stack(children: [
    //
    // ]);
    return   IconBadge( model );
  }

  //-------------------------------------------------------------- title

  Widget _titleTv( ) {
    return TextTemplate.t( model.title,
        levelDS: LevelDS.l3,
        color: getColorSelectedOrNot( )
    );
  }

  //------------------------------------------------------------- separator

  Widget separatorLineColorSelectedOrNot( ){
    return Container( width:  sizeTab,
      height: 2,
      color: getColorSelectedOrNot(  ),
    );
  }


  Color getColorSelectedOrNot(  ) {
    //case selected
    if( currentEnumNavigationPage ==  model.enumNavigationPage ) {
      return  colorSelected;
    }

    //case not selected
    return  colorUnSelected;
  }



}