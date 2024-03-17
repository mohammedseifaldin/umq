import 'package:umq/tools/network/BackendConstant.dart';

class EndPoint {
  ///subscribePackage
  static final String subscribePackageCreate =
      BackendConstant.baseUrlv1 + "/subscribe_package";
  static final String subscribePackageGetWithPaginate =
      BackendConstant.baseUrlv2Public + "/subscribe_package/get_with_paginate";
  static final String subscribePackageGetAll =
      BackendConstant.baseUrlv2Public + "/subscribe_package/get_all";
  static final String subscribePackageHide =
      BackendConstant.baseUrlv1 + "/subscribe_package";

  ///subscribe Users
  static final String subscribeUsersCreate =
      BackendConstant.baseUrlv1 + "/subscribe_user";
  static final String subscribeUsersGetWithPaginate =
      BackendConstant.baseUrlv1 + "/subscribe_user";
  static final String subscribeUsersGetCurrentSubscribe =
      BackendConstant.baseUrlv2 + "/subscribe_user/current_user_subscibe";
}
