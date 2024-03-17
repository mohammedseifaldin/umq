
import 'package:umq/modules/notification/data/source/NotificationUserListAPI.dart';
import 'package:umq/modules/notification/presentation/customer/NotificationListPage/v/NotificationPage.dart';

import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension NotificationListController on NotificationState {


  Future startApiGetList() async {

    //check guest
    isGuest = await UserSingleTone.instance().isGuest();
    if( isGuest ) {
      setState((){
        isGuest = true;
      });
      return;
    }

    //progress
    setState((){
      progress = true;
    });

    //api
    _apiGetList();
  }


  Future _apiGetList() async {
    new NotificationUserListAPI().getUserListNotification( 100, (status, msg, response)  {

      //check failed
      if( status == false ) {
        //progress
        setState((){
          progress = false ;
        });
        ToolsToast.i(context, msg);
        return;
      }

      isNotFoundNotification = response.data!.length == 0;

      //progress
      setState((){
        this.response = response;
        progress = false ;
      });

    });
  }


}