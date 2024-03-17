import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/subscribe/data/request/RequestSubscribePackageHide.dart';

import 'package:umq/modules/subscribe/data/source/SubscribeDataSource.dart';
import 'package:umq/modules/subscribe/provider/SubscribeChangeNotifier.dart';

extension SubscribePackageList on SubscribeChangeNotifier {


  //---------------------------------------------------------------------- list

  Future subscribePackageRefreshOrDownloadNextPage({required BuildContext context, required bool isResetPage}) async {
    Log.i("subscribePackageRefreshOrDownloadNextPage() - isResetPage: $isResetPage");

    // reset paginate
    if( isResetPage ) {
     responsePaginateSubscribePackage = null;
    }

    //hide keyboard
    FocusScope.of( context).unfocus();

    _adminPackagesUpdateProgress( true );

    //listener
    await _getPackagesWithPaginateDataThenNotifyChange( context);
  }


  Future _getPackagesWithPaginateDataThenNotifyChange(BuildContext context  ) async  {

    //wait
    responsePaginateSubscribePackage  = await SubscribeDataSource.getListPackageWithPaginate(  _getNextPageNumber() );

    _adminPackagesUpdateProgress( false );

    if( responsePaginateSubscribePackage != null && responsePaginateSubscribePackage!.data != null ) {
      _successUpdatePackage(   );
    }
  }


  int _getNextPageNumber(){
    int pageNew = 1;
    if(responsePaginateSubscribePackage != null ) {
      pageNew = 1 + responsePaginateSubscribePackage!.data!.currentPage!;
    }
    Log.i("_getNextPageNumber() - pageNew: $pageNew");
    return pageNew;
  }

  //---------------------------------------------------------------- update single


  Future subscribePackageHidde(BuildContext context, int id) async {
    Log.i("subscribePackageHidde() - start");
    _adminPackagesUpdateProgress( true );


    var request = new RequestSubscribePackageHide(packageId: id, hidden: 1);
    await SubscribeDataSource.hidePackage( request );
    Log.i("subscribePackageHidde() - hidePackage done");

    ///refresh
    await subscribePackageRefreshOrDownloadNextPage(context: context, isResetPage: true);
    Log.i("subscribePackageHidde() - refresh done");
  }


  //------------------------------------------------------------------- helper

  void _successUpdatePackage(){
    notifyListeners();
  }


  void _adminPackagesUpdateProgress(bool update  ) {
    adminPackagesProgressStatus = update;
    notifyListeners();
  }


}