import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import '../general/m/MFcm.dart';




   Future eventData(MMessageFcm mFcm ) async {
    Log.i( "eventData- mFcm: " + mFcm.toString() );


    // //check type location
    // if( TypesDataPayloadChecker.isDataType_location( mFcm )  ) {
    // await SocketDataFcmListener.eventLocation( mFcm);
    // return;
    // }


  }


