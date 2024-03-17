
import 'package:umq/modules/cart/data/model/MOrder.dart';
import 'package:umq/modules/cart/presentation/admin/list/v/OrderListAdminPage.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';




extension ExtensionRowButtonController on OrderListAdminState {

  //------------------------------------------------------------------- show product

  Future click_show_detail( MOrder m ) async {
    GoToAdmin.orderDetail_edit( context, m , this  );
  }

  // //------------------------------------------------------------------- hidden
  //
  // Future hidden_click(MOrder m ) async{
  //   //progress
  //   if(progressState != null ) progressState!.show();
  //
  //   //listener
  //   await CityHiddenAPI().action( m.id.toString(), (code, status) {
  //     if(progressState != null ) progressState!.dismiss();
  //     refreshFunction(isResetPage: true  );
  //
  //   });
  // }


}