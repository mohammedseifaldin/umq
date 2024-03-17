
import 'package:umq/modules/setting/presentation/admin/detail/v/SettingDetailAdminPage.dart';
import 'package:umq/modules/setting/data/model/MSettingAdmin.dart';


extension MapRequest on SettingDetailAdminState {

  MSettingAdmin mapTextFieldValuesToRequestAPI() {

    //set date edit old
    MSettingAdmin m = new MSettingAdmin( );
    if( mEdit != null ) {
      m = mEdit!;
    }

    //set update new data/or/ create new object

    m.aboutUs = aboutUsUrl;
    m.terms = termsUrl;

    return m;
  }
}