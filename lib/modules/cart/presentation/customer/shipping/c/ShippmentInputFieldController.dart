import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/place/data/response/ResponseListCity.dart';
import 'package:umq/modules/cart/presentation/customer/shipping/v/CartShipmentPage.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/values/ToolsValue.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ShippmentInputFieldController on CartShipmentState {

  //------------------------------------------------------------------- city download

  void getDownloadCity() async {
    String url =  BackendConstant.domain  + "/public/api/v2/city/?page=1&paginator=100";
    await NetworkManagerDio().callBack( url , type: NetworkTypeDio.get , callback: (status, msg, json ){
      // Log.i( "getDownloadCity() - json: " + json.toString()  );
      //check
      if( status == false ) {
        ToolsToast.i(context,  "Refresh the Page");
        return;
      }

      //set
      ResponseCityList response = ResponseCityList.fromJson(json);

      //set data
      setState(() {
         listCity = response.data!.data!;
      });
    });
  }

  //---------------------------------------------------------------------- set edit data

  void setEditData() async {
    _setAddressEdit();
    _setCityForEdit();

  }

  _setAddressEdit(){
    String addressCurrent = OrderCurrentSingletone.instance().address;
    if( ToolsValue.isEmpty(addressCurrent) ) {
      return;
    }

    setState( (){
      address_txt = addressCurrent;
      address_con.text = addressCurrent;
    //  OrderCurrentSingletone.instance().address = null; //avoid set many times
    });

  }


  _setCityForEdit(){
    MCity cityCurrent = OrderCurrentSingletone.instance().city;
    if( cityCurrent == null ) return;

    setState( (){
      citySelectedName = MCityTools.getNameByLang(context, cityCurrent);
      citySelectedObject = cityCurrent;
      //  OrderCurrentSingletone.instance().city = null; //avoid set many times
    });
  }


}