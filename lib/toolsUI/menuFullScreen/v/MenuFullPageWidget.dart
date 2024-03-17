
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/resource/template/scrollview/SingleChildScrollViewTemplate.dart';
import 'package:flutter/material.dart';
import 'package:umq/toolsUI/admin/menu/GenerateSlideForProject.dart';
import 'package:umq/toolsUI/admin/toolbar/AdminToolbar.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/menuFullScreen/m/MItemSlide.dart';

/**

-------------------------------------- how to open page

    static void menuFullPage(BuildContext context ) {
    List<MItemSlide> listSlide = GenerateSlideForProject.getScubaProjectItems(context);
    var page = MenuFullPageWidget(listSlide:  listSlide  );
    var transparent = PageRouteBuilder(
    opaque: false,
    pageBuilder: (_, __, ___) => page,
    );
    Navigator.push(context ,  transparent  );
    }

    
    --------------------------------------- how to genearte item
    Widget getMenuDashboard(){
    return DashboardMenuWidget(
    pageTitle: pageTitle,
    pageGoTo: tableDataAndFilterButtons(),
    paginationChange: (newPage) => pageChangeTo(newPage) ,
    paginateState : (value) => paginateState = value,
    progressState: ( value) => progressState = value );
    }

 */
class MenuFullPageWidget extends StatefulWidget {
 
  List<MItemSlide> listSlide ;

  MenuFullPageWidget({
    required this.listSlide
});

  @override
  MenuProjectState createState() {
    return MenuProjectState();
  }

}

class MenuProjectState extends State<MenuFullPageWidget> {

  static var colorBackground = HexColor( ColorProject.blueTransparentDark);

  BuildContext? contextMenu;

  @override
  Widget build(BuildContext context) {
    this.contextMenu = context;

    var cont = Container( child: getScroll(),
    color: colorBackground,
    );
    return cont;
    // return Scaffold(
    //
    //   resizeToAvoidBottomInset: false ,
    //   body: cont,
    // );
  }


  Widget getScroll(){
    var listWidget = addCancelButtonToFirstChildren();

    var sc =  SingleChildScrollViewTemplate.t(context, Axis.vertical,
        listWidget, 0);
    return sc;
  }

  //------------------------------------------------------------------- map list

  List<Widget> addCancelButtonToFirstChildren(){
    var listWidget = GenerateSlideForProject.ListItemSlideWidget(context);

    //back button
    listWidget.insert(0, bt_dismisAllPage() );

    return listWidget;
  }

  //-------------------------------------------------------------------- button dismiss
  
  Widget bt_dismisAllPage(){
    var img =  ImageView(width: 50+10, height: 50+10,
    assetAspectRatio: DrawableProject.admin( "cancel"),
    padding: EdgeInsets.all(10),
    onPressed: (){
      Navigator.pop( context );
    },);


    var marginValue = AdminToolbar.toolbarHeightLayer ; //+ DSDimen.space_level_2;

    return Container( child: img,
    alignment: Alignment.topRight,
    padding: EdgeInsets.only(top: marginValue ),
    width: DeviceTools.getWidth(context),
      // color: colorBackground,
    );
  }


}