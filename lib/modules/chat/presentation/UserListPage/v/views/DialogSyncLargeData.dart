import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';

extension DialogSyncLargeData on ChatUserListState {
  //
  // Widget dialogSyncLargeData(){
  //   // check dialog sync large data shown
  //   if( isDialogSyncLargeDataShow == false  ) {
  //     return EmptyView.zero();
  //   }
  //   return _showDiloag();
  // }
  //
  //
  // Widget _showDiloag() {
  //
  //   var dialogContent = Stack( children: [
  //
  //     EmptyView.empty(  DeviceTools.getWidth(context), 50 ),
  //
  //     //title
  //     tv_title(),
  //
  //     //percentage
  //     Positioned(child:  tv_counterDownload() , right: 0)
  //   ]);
  //
  //
  //   //card
  //   var card =  shadowCardViewCustomeRadius( dialogContent );
  //
  //   return Container( child: card,
  //  margin: EdgeInsets.all(    DSDimen.space_level_1 ),
  //   );
  // }
  //
  //
  //
  // Widget shadowCardViewCustomeRadius(Widget child) {
  //
  //   //elevation
  //   var physical =   PhysicalModel(
  //     elevation: 20,
  //     color: Colors.grey, // DSColor.cardview_background_color,  // Colors.black87, //
  //     child: child,
  //   );
  //
  //   //custome radius
  //   var objRadius = Radius.circular( 15 );
  //   var radiusCustom = BorderRadius.all(   objRadius  );
  //
  //   //clip to card shape
  //   return ClipRRect(
  //     borderRadius: radiusCustom,
  //     child: physical,
  //   );
  // }
  //
  //
  // Widget tv_title() {
  //   return TextTemplate.t( "Downloading",
  //       padding: EdgeInsets.all( DSDimen.space_level_2 ),
  //
  //       levelDS: LevelDS.l2 );
  // }
  //
  //
  // Widget tv_counterDownload() {
  //   String msg = "" + dialogLargeData_progress.toString() + " / " + dialogLargeData_total.toString();
  //   return  TextTemplate.t( msg ,
  //       padding: EdgeInsets.all( DSDimen.space_level_2 ),
  //       levelDS: LevelDS.l2 );
  // }


}
