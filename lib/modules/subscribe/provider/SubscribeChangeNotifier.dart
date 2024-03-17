

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/request/RequestCreateSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponsePaginateSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponseSingleSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponseArraySubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponseSubscribeUsers.dart';
import 'package:umq/modules/subscribe/data/source/SubscribeDataSource.dart';

import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class SubscribeChangeNotifier extends ChangeNotifier {

  //-------------------------------------------------------------------------- variable

  //page create package
  bool createPackageProgressStatus = false;

  //page get list package
  bool adminPackagesProgressStatus = false;
  ResponsePaginateSubscribePackage? responsePaginateSubscribePackage;

  //page get list users
  bool adminUsersProgressStatus = false;
  ResponseSubscribeUsers? responseSubscribeUsers;

  //page subscribe by admin
  bool subscribeUserByAdminProgressStatus = false;
  ResponseArraySubscribePackage? allSubscribePackage;

  //-------------------------------------------------------------------------- get instance

  static SubscribeChangeNotifier getListenFalse(BuildContext context){
    return Provider.of<SubscribeChangeNotifier>(context, listen: false);
  }


  static SubscribeChangeNotifier getListenTrue(BuildContext context){
    return Provider.of<SubscribeChangeNotifier>(context, listen: true);
  }




}