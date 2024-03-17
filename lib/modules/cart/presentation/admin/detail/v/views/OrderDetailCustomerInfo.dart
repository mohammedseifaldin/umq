// import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:umq/modules/cart/presentation/admin/detail/v/OrderDetailAdminPage.dart';
// import 'package:umq/admin/tools/resource/ResourceDimenAdmin.dart';
//
// extension OrderDetailCustomerInfo on OrderDetailAdminState {
//
//   Widget orderDetailCustomerInfo(){
//     return ColumnTemplate.t(
//         decoration: BoarderHelper.cardView(),
//         padding: EdgeInsets.all( DSDimen.space_level_2),
//         margin: EdgeInsets.only(
//             top: DSDimen.space_level_2,
//             left: DSDimen.space_level_2,
//             right: DSDimen.space_level_2
//         ),
//         children: [
//
//           tvTitle(),
//           EmptyView.empty(0, DSDimen.space_level_2 ), //margin
//
//           customerName(),
//           separator(),
//
//           priceProducts(),
//           separator(),
//
//           vatFees(),
//           separator(),
//
//           total(),
//           separator(),
//
//           noticeShipmentFees()
//         ]);
//   }
//
//   Widget tvTitle() {
//     return TextTemplate.t( "Customer information" ,
//         levelDS: LevelDS.l1
//     );
//   }
//
//   Widget customerName(){
//     var title =  TextTemplate.t(
//         "Name",
//         levelDS: LevelDS.l2
//     );
//
//     String name =  widget.mShow.user!.name! ;
//
//     //check not selected
//     if( ToolsValidation.isEmpty( name) ) {
//       name = "Not Selected";
//     }
//
//     var nameTv = TextTemplate.t( name, levelDS: LevelDS.l3 ,
//         margin: EdgeInsets.only(top: DSDimen.space_level_3) );
//
//
//     return ColumnTemplate.t( children: [
//       title,
//       nameTv
//     ]);
//   }
//
// }