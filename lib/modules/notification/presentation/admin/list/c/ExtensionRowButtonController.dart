import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/place/presentation/admin/city/list/c/SearchDownloadController.dart';
import 'package:umq/modules/place/presentation/admin/city/list/m/action/CityHiddenAPI.dart';
import 'package:umq/modules/place/presentation/admin/city/list/v/CityListAdminPage.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';

extension ExtensionRowButtonController on CityListAdminState {

  //------------------------------------------------------------------- show product

  Future click_show_detail( MCity m ) async {
    GoToAdmin.cityDetail_edit( context, m , this  );
  }

  //------------------------------------------------------------------- hidden

  Future hidden_click(MCity m ) async{
    //progress
    if(progressState != null ) progressState!.show();

    //listener
    await CityHiddenAPI().action( m.id.toString(), (code, status) {
      if(progressState != null ) progressState!.dismiss();
      refreshFunction(isResetPage: true  );

    });
  }


}