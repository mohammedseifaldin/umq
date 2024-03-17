

import 'package:umq/modules/setting/presentation/admin/slider/list/c/SearchDownloadController.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/m/action/SliderHiddenAPI.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/v/SliderListAdminPage.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';

import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

extension ExtensionRowButtonController on SliderListAdminState {

  //------------------------------------------------------------------- show product

  Future click_show_detail( MSlider m ) async {
    GoToAdmin.slideDetail_edit( context, m , this  );
  }

  //------------------------------------------------------------------- hidden

  Future hidden_click(MSlider m ) async{
    //progress
    if(progressState != null ) progressState!.show();

    //listener
    await SliderHiddenAPI().action( m.id.toString(), (code, status) {
      if(progressState != null ) progressState!.dismiss();
      refreshFunction(isResetPage: true  );

    });
  }


}