import 'package:umq/modules/setting/presentation/admin/detail/v/SettingDetailAdminPage.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';

extension DebugAutomator on SettingDetailAdminState {

  //------------------------------------------------------------------- automator

  void debugAutomator() {
    if( EnvironmentConstant.isLive ) return;


    setState(() {
      int counter = 23;
      // title_txt = "conference name " + counter.toString() ;
      // title_controller.text = title_txt;


    });
  }


}