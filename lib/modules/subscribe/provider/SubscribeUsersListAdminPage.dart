import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/subscribe/data/request/RequestSubscribePackageHide.dart';

import 'package:umq/modules/subscribe/data/source/SubscribeDataSource.dart';
import 'package:umq/modules/subscribe/provider/SubscribeChangeNotifier.dart';

extension SubscribeUsersListAdminPage on SubscribeChangeNotifier {


  //---------------------------------------------------------------------- list

  Future subscribeUsersRefreshOrDownloadNextPage({required BuildContext context, required bool isResetPage}) async {
    Log.i("subscribeUsersRefreshOrDownloadNextPage() - isResetPage: $isResetPage");

    // reset paginate
    if( isResetPage ) {
      responseSubscribeUsers = null;
    }

    //hide keyboard
    FocusScope.of( context).unfocus();

    _progressUpdate( true );

    //listener
    await _getUserSubscribedWithPaginateDataThenNotifyChange( context);
  }


  Future _getUserSubscribedWithPaginateDataThenNotifyChange(BuildContext context  ) async  {

    //wait
    responseSubscribeUsers  = await SubscribeDataSource.getListUsersWithPaginate(  _getNextPageNumber() );

    _progressUpdate( false );

    if( responseSubscribeUsers != null && responseSubscribeUsers!.data != null ) {
      _successUpdatePackage(   );
    }
  }


  int _getNextPageNumber(){
    int pageNew = 1;
    if(responseSubscribeUsers != null ) {
      pageNew = 1 + responseSubscribeUsers!.data!.currentPage!;
    }
    Log.i("_getNextPageNumber() - pageNew: $pageNew");
    return pageNew;
  }


  //------------------------------------------------------------------- helper

  void _successUpdatePackage(){
    notifyListeners();
  }


  void _progressUpdate(bool update  ) {
    adminUsersProgressStatus = update;
    notifyListeners();
  }


}