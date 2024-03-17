

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/cart/data/source/CartCounterApi.dart';
import 'package:umq/modules/cart/data/response/ResponseCartCounter.dart';
import 'package:umq/modules/cart/data/response/ResponseBadgeCounter.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class CartChangeNotifier extends ChangeNotifier {

  ResponseBadgeCounter? responseBadgeCounter;
  ResponseCartCounter? responseCartCounter;


  static CartChangeNotifier getListenFalse(BuildContext context){
    return Provider.of<CartChangeNotifier>(context, listen: false);
  }

  static CartChangeNotifier getListenTrue(BuildContext context){
    return Provider.of<CartChangeNotifier>(context, listen: true);
  }

  int getBadgeCounter(){
    if( responseBadgeCounter == null ) return 0;
    return responseBadgeCounter!.badgeCounter??0;
  }


  Future<ResponseBadgeCounter?> badgeCounterDownloadAfterValidate(BuildContext context  ) async {
    //validate
    if( UserSingleTone.instance().isGuest() ) {
      return null ;
    }

    //api
    responseBadgeCounter = await new CartCounterApi().badgeCounter(   );
    notifyListeners();
    return responseBadgeCounter;
  }


  Future<ResponseCartCounter?> increment(BuildContext context, int productId, int providerId, String productName ) async {

    //api
    responseCartCounter = await new CartCounterApi().incrementCart( productId, providerId );

    //case failed
    if ( ToolsAPI.isFailed( responseCartCounter!.code) ) {
      //msg
      ToolsToast.i(context, "Failed To Update Cart");
      return responseCartCounter;
    }

    ToolsToast.i(context, '$productName Added To Cart');
    // notifyListeners();
    await badgeCounterDownloadAfterValidate(context);

    return responseCartCounter;
  }


  Future<ResponseCartCounter?>  decrement(BuildContext context, int productId, int providerId, String productName  ) async {


    //api
    responseCartCounter = await new CartCounterApi().decrementCart( productId, providerId );

    //case failed
    if ( ToolsAPI.isFailed( responseCartCounter!.code) ) {
      //msg
      ToolsToast.i(context, "Failed To Update Cart");
      return responseCartCounter;
    }

    ToolsToast.i(context, '$productName Added To Cart');
    // notifyListeners();
    await badgeCounterDownloadAfterValidate(context);
    return responseCartCounter;
  }



  Future<ResponseCartCounter?> cancel(BuildContext context, int productId, int providerId, String productName  ) async  {

    //api
    responseCartCounter = await new CartCounterApi().cancel( productId, providerId );

    //case failed
    if ( ToolsAPI.isFailed( responseCartCounter!.code) ) {
      //msg
      ToolsToast.i(context, "Failed To Update Cart");
      return responseCartCounter;
    }

    ToolsToast.i(context, '$productName Cancel From Cart');
    // notifyListeners();
    await badgeCounterDownloadAfterValidate(context);
    return responseCartCounter;
  }


}