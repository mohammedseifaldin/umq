import 'package:umq/modules/notification/presentation/admin/detail/v/NotificationCreateAdminPage.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';

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