import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/notification/data/model/MNotificationAdmin.dart';
import 'package:umq/modules/notification/presentation/customer/NotificationListPage/v/NotificationPage.dart';

import 'package:umq/tools/time/TimeTools.dart';

extension ItemListNotification on NotificationState {


  Widget getItemListNotification( MNotificationAdmin mNotificationAdmin ){
    return ColumnTemplate.t(

        margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_2/2, horizontal: DSDimen.space_level_2),
        padding: EdgeInsets.all( DSDimen.space_level_2 ),
        decoration: BoarderHelper.cardView(),
        children: [

          _titleTv(mNotificationAdmin),
          _messageTv( mNotificationAdmin),
          _dateTv( mNotificationAdmin)
    ]);
  }


  Widget _titleTv(MNotificationAdmin mNotificationAdmin) {
    return TextTemplate.t( mNotificationAdmin.title, levelDS: LevelDS.l2 );
  }

  Widget _messageTv(MNotificationAdmin mNotificationAdmin) {
    return TextTemplate.t( mNotificationAdmin.message,
        margin: EdgeInsets.only(top: DSDimen.space_level_2),
        levelDS: LevelDS.l3 );
  }


  Widget _dateTv(MNotificationAdmin mNotificationAdmin) {

    String date = TimeTools.convertTimestamp_yyymmddhhmmPM( mNotificationAdmin.created! );

    return TextTemplate.t( date,
        margin: EdgeInsets.only(top: DSDimen.space_level_2),
        levelDS: LevelDS.l4 );
  }





}