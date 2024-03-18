import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/place/data/response/ResponseListCity.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/v/edit_screen.dart';
import 'package:umq/tools/network/BackendConstant.dart';

extension DownloadCityController on EditProfileState {


  getDownloadCity() async {

    String url =  BackendConstant.domain  + "/public/api/v2/city/?page=1&paginator=100";
    await NetworkManagerDio().callBack( url , type: NetworkTypeDio.get , callback: (status, msg, json ){

      // Log.i( "getDownloadCity() - json: " + json.toString()  );

      ResponseCityList response = ResponseCityList.fromJson(json);

      Log.i( "getDownloadCity() - response: " + response.toString()  );

      //set data
      setState(() {

      con.listCity = response.data!.data!;
      });


    });

  }



}