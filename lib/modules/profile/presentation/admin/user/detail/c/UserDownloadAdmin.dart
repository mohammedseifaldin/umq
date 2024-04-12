import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/place/data/source/CityListAPI.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/c/EditUserController.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/v/UserDetailAdminPage.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension DownloadUserDetail on UserDetailAdminState {
  Future city_download() async {
    //check downloaded before
    if (UserDetailAdminState.city_list.isNotEmpty) {
      /**
       case already download this static data before
       */
      setPreviousCity();
      return;
    }

    if (prg != null) prg!.show();

    await CityListAPI().getData((status, msg, response) {
      if (prg != null) prg!.dismiss();

      //check failed
      if (status == false) {
        ToolsToast.i(contextPage!, "city $msg");
        return;
      }

      //update
      setState(() {
        //1- step: save new data
        UserDetailAdminState.city_list = response.data!.data!;
        Log.i(
            "city_download() - city_list: ${UserDetailAdminState.city_list.length}");

        //2- step: show edit data
        setPreviousCity();
      });
    });
  }
}
