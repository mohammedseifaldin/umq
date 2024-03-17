
import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_list/SubscribePackageListAdminPage.dart';

import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/modules/subscribe/provider/SubscribePackageListAdminPage.dart';



extension ExtensionRowButtonController on SubscribePackageListAdminPageState {

  //------------------------------------------------------------------- show product

  Future click_show_detail( MSubscribePackage m ) async {
    GoToAdmin.subscribePackageDetailAdmin( context, m , this  );
  }

  //------------------------------------------------------------------- hidden

  Future hidden_click(MSubscribePackage m ) async{

    provider!.subscribePackageHidde(context, m.id??0);
  }


}