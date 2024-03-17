//
// import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
// import 'package:flutter/material.dart';
//
// import 'package:umq/modules/subscribe/presentation/admin/package_list/SubscribeUsersListAdminPage.dart';
// import 'package:umq/modules/subscribe/provider/SubscribeUsersListAdminPage.dart';
//
//
//
// extension HeaderToolbarAdminPage on SubscribePackageListAdminPageState {
//
//   //---------------------------------------------------------------------- build
//
//   Widget headerToolbarAdminPage() {
//     var row =  RowTemplate.scroll( context, [
//
//      bt_refresh(),
//
//     ] );
//
//     return Container(
//       child: row,
//       // color: DSColor.menu_background,
//       alignment: Alignment.centerLeft,
//      // padding: EdgeInsets.only(top : DSDimen.space_level_2 ),
//       margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 ),
//     );
//   }
//
//
//
// //------------------------------------------------------------------------- refresh
//
//   Widget bt_refresh() {
//     var margin  = EdgeInsets.only(
//         top: DSDimen.space_level_2,
//         // left: DSDimen.space_level_1 ,
//         // right: DSDimen.space_level_3,
//         bottom:  DSDimen.space_level_2);
//     return ButtonTemplate.t( "Refresh", () {
//       provider!.subscribePackageRefreshOrDownloadNextPage( context: context, isResetPage: false );
//     },
//       levelDS: LevelDS.l2,
//     margin: margin,
//     );
//   }
//
//
//
// }
