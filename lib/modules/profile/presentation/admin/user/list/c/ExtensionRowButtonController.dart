import 'package:umq/modules/profile/presentation/admin/user/list/c/SearchDownloadController.dart';
import 'package:umq/modules/profile/data/source/UserBlockAPI.dart';
import 'package:umq/modules/profile/data/source/UserHiddenAPI.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/UserListAdminPage.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';

import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

extension ExtensionRowButtonController on UserListAdminState {

  //------------------------------------------------------------------- show product

  Future click_show_detail( MUser m ) async {
    GoToAdmin.userDetail_edit( context, m , this  );
  }

  //------------------------------------------------------------------- block

  Future block_click( MUser m ) async {
    //progress
    if(progressState != null ) progressState!.show();

    //change status
    if( ToolsAPI.parseBoolean_int( m.block )  ) {
      await UserBlockAPI().unblock( m.id.toString(), (code, status) {
        if(progressState != null ) progressState!.dismiss();
        refreshFunction(isResetPage: true  );

      });
    } else {
      await UserBlockAPI().block( m.id.toString(), (code, status) {
        if(progressState != null ) progressState!.dismiss();
        refreshFunction(isResetPage: true  );

      });
    }

  }

  //------------------------------------------------------------------- hidden

  Future hidden_click(MUser m ) async{
    //progress
    if(progressState != null ) progressState!.show();

    //listener
    await UserHiddenAPI().action( m.id.toString(), (code, status) {
      if(progressState != null ) progressState!.dismiss();
      refreshFunction(isResetPage: true  );

    });
  }


}