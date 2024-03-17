import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/modules/notification/presentation/admin/detail/v/NotificationCreateAdminPage.dart';

extension PickerListener on NotificationCreateAdminState {

  Future pickerUserDialogOpen() async {

    GoToAdmin.pickerUser( context, this,  select: ( MUser mUser) {


      if( mUser == null ) return;
     // Log.i( "pickerUserDialogOpen() - mUser " + mUser.toString() );

      //refresh
      setState( (){

        userSelected =  mUser;
      });

    });
  }


}