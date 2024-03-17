
import 'package:umq/modules/profile/presentation/admin/orginization/list/c/SearchDownloadController.dart';
import 'package:umq/modules/profile/data/source/OrgHiddenAPI.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/list/v/OrgListAdminPage.dart';

import 'package:umq/tools/navigate/GoToAdmin.dart';

import 'package:umq/modules/profile/data/model/MOrganization.dart';


import 'package:umq/tools/network/ToolsAPI.dart';

extension ExtensionRowButtonController on OrgListAdminState {

  //------------------------------------------------------------------- show product

  Future click_show_detail( MOrganization m ) async {
    GoToAdmin.orgiizationDetail_edit( contextPage!, m , this  );
  }

  //------------------------------------------------------------------- hidden

  Future hidden_click(MOrganization m ) async{
    //progress
    if(progressState != null ) progressState!.show();

    //listener
    await OrgHiddenAPI().action( m.id.toString(), (code, status) {
      if(progressState != null ) progressState!.dismiss();
      refreshFunction(isResetPage: true  );

    });
  }


}