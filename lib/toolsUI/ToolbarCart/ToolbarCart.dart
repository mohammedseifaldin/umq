
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/toolbarBackButton/ToolbarProjectBack.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class ToolbarCartView extends StatefulWidget {

  //size
  static double frameHeight_rowTitle = ToolbarProjectBack.frameHeight;
  static double frameHeight_rowTabsChoose = 70;
  static double frameHeight = frameHeight_rowTitle +  frameHeight_rowTabsChoose;
  double sizeTab = 0;
  double sizeIcon = 15;

  BuildContext contextPage;
  ValueChanged? onBackClick;

  //info
  String title = "";
  int currentPosition = 1 ;

  ToolbarCartView( this.contextPage, this.title, this.currentPosition , {
    ValueChanged? this.onBackClick
  } );

  @override
  ToolbarCartState createState() {
    return ToolbarCartState();
  }


}

class ToolbarCartState extends State<ToolbarCartView> {

  //-------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    calculateSize();

    return ColumnTemplate.t( children: [

      ToolbarProjectBack( widget.contextPage,  widget.title, onBackClick: widget.onBackClick),

      // EmptyView.empty( 0, 5   ),

      threeTabsCart()
    ]);
  }

  void calculateSize(){
    widget.sizeTab = DeviceTools.getThirdWidth(context );
  }


  Widget threeTabsCart() {
    var row =  RowTemplate.scroll( context,    [
      getTabItem( 1, "Shipment", Icons.local_shipping_outlined),
      getTabItem( 2, "Payment", Icons.payment),
      getTabItem( 3, "Receipt", Icons.receipt_outlined),
    ]);

    //boarder
    var boarder = Container( child: row, decoration: getBoarder(),);


    //color of white space
    return Container( child:  boarder, color: HexColor( ColorProject.grey),);
  }

  //-------------------------------------------------------------------- generic tools ui


  Decoration getBoarder() {
    var radius = BorderRadiusTools.get(
        radius_topLeft: DSDimen.ds_size_corner_level_1 ,
        radius_topRight: DSDimen.ds_size_corner_level_1
    );
    return BoarderHelper.cardView(
        radiusBorder:  radius,
        // colorBackground: HexColor( ColorProject.blue_fish_back)
    );
  }

  Color getColorSelectedOrNot(int position ) {
    //case selected
    if( position == widget.currentPosition ) {
      return HexColor( ColorProject.blue_fish_back);
    }

    //case not selected
    return HexColor( ColorProject.greyDark);
  }


  Widget _separator(int position){
    return Container( width: widget.sizeTab,
      height: 2,
      color: getColorSelectedOrNot(position ),
    );
  }

  void clickOnPosition(int positionNew ){
    //click on same position
    if( positionNew == widget.currentPosition ) return;

    //navigate
    if( positionNew == 1 ) {
      GoTo.cartShipmentPage(context);
      return;
    }
    if( positionNew == 2 ) {
      GoTo.cartPaymentMethod(context);
      return;
    }
    if( positionNew == 3 ) {
      GoTo.cartReceiptPage(context);
      return;
    }

  }
  
  //----------------------------------------------------------------- tab  item

  Widget getTabItem(int position, String title, IconData icon){
    var col =  ColumnTemplate.t(
        width: widget.sizeTab,
    //  height: ToolbarCartView.frameHeight_rowTabsChoose,
       colorBackground: Colors.transparent,
       //  decoration: getBoarder(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EmptyView.empty( 0,  DSDimen.space_level_4 /2),
          _iconImage( position, icon),

          EmptyView.empty( 0,  DSDimen.space_level_4 /2 ),
          _titleTv(position, title),

          EmptyView.empty( 0,  DSDimen.space_level_4 /2 ),
          _separator(position)
        ]);

    return GestureDetector( child:  col , onTap: () {
      clickOnPosition( position);
    });
  }


  Widget _iconImage(int position,  IconData icon ) {
    return Icon(
      icon, //Icons.location_city_outlined,    //Icons.local_shipping_outlined,
      size: widget.sizeIcon,
      color: getColorSelectedOrNot( position),
    );
  }


  Widget _titleTv(int position, String title) {
    return TextTemplate.t( title, //"Address",
        levelDS: LevelDS.l3,
      color: getColorSelectedOrNot(position)
    );
  }


}
