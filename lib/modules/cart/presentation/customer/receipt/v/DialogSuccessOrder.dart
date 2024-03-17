import 'package:umq/modules/cart/data/response/ResponseOrderCreate.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/CartReceiptPage.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/dialog/MessageGeneralDialog.dart';

extension DialogSuccessOrder on CartReceiptState {

  Future showDialogSuccess(ResponseOrderSingle responseOrderSingle) async {

    String title = "Order Created Successfully";
    String msg = "Order Number #" + responseOrderSingle.data!.id!.toString();
    MessageGeneralDialog.scucces(context, title, msg, (isClickOnYes)  {
      GoTo.homeStudent(context);
    });
  }


  /**
      Widget dialogSuccessOrder(){
      if( showDialogSuccessCreateOrder == false ) {
      return EmptyView.zero();
      }

      return _contentDialog();
      }

      //------------------------------------------------------------------- content

      Widget _contentDialog() {

      //column
      var column = ColumnTemplate.t( children: [
      tvOk
      ]);

      //cont
      return Container( child: column,
      width: 350,
      alignment: Alignment.center,
      margin: EdgeInsets.all( DSDimen.space_level_1),
      padding: EdgeInsets.all( DSDimen.space_level_2 ),
      decoration: BoarderHelper.cardView(),
      );
      }
   */



}