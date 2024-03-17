import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:provider/provider.dart';
import 'package:umq/tools/constant/AdminConstant.dart';
import 'package:umq/toolsUI/admin/paginate/v/PaginateAdminWidget.dart';
import 'package:umq/toolsUI/admin/paginate_number/PaginateNumberWidget.dart';
import 'package:umq/toolsUI/admin/toolbar/AdminToolbar.dart';
import 'package:umq/modules/subscribe/presentation/admin/user_detail/SubscribeUserByAdminPage.dart';
import 'package:umq/modules/subscribe/presentation/admin/user_list/logic/MapModelToWidget.dart';

import 'package:umq/modules/subscribe/provider/SubscribeChangeNotifier.dart';
import 'package:umq/modules/subscribe/provider/SubscribeUsersListAdminPage.dart';


class SubscribeUsersListAdminPage extends StatefulWidget {


  @override
  SubscribeUsersListAdminPageState createState() => SubscribeUsersListAdminPageState();
}

class  SubscribeUsersListAdminPageState extends ResumableState<SubscribeUsersListAdminPage> {

  //--------------------------------------------------------------- data and varaible

  String pageTitle = "Subscribe Users";

  //provider
  SubscribeChangeNotifier? provider;

  //response and table

  List<Widget> listRow = [];  //table : header + result

  //paginate
  PaginateAdminState? paginateState;

  //--------------------------------------------------------------- life cycle

  @override
  void onReady() {
    super.onReady();
    onResume();
  }

  @override
  void onResume(){
    super.onResume();
    Log.i( "lifecycle - onResume - $pageTitle");
    /**
        must to refresh the page after edit the record of table
     */
    provider?.subscribeUsersRefreshOrDownloadNextPage(context: context, isResetPage: true );
  }

  //--------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    Log.i( "lifecycle - build - $pageTitle");
    return consumerProvider();
  }


  Widget consumerProvider() {
    return Consumer<SubscribeChangeNotifier>(
      builder: ( context, provider, child) {
        this.provider = provider;

        initRowWidgetTableAndSetHeaderData();
        mapResponseArrayToWidget();
        return scaffoldPage();
      },
    );
  }

  //----------------------------------------------------------------- scaffold

  Widget scaffoldPage(){

    return PageTemplate.t( this,
        title: pageTitle ,

        //toolbarMessage
        toolbar: tooblar() ,
        toolbar_height:  AdminToolbar.toolbarHeightLayer,

        //navigate
        navigationBottom: getPaginateBar(),
        navigationBottom_height: PaginateAdminWidget.getHeightFrame( context),

        content: pageContent(),
    );
  }

  //------------------------------------------------------------------ tooblar

  Widget tooblar(){
    return AdminToolbar(
      contextPage: context,
      pageTitle: pageTitle,
      clickRefresh : (b){
        provider!.subscribeUsersRefreshOrDownloadNextPage(context: context, isResetPage: true );
      },

      createPageNameGoTo:  SubscribeUserByAdminPage(),
      resume: this,

    );
  }

  //----------------------------------------------------------------- paginate at navigation bar

  Widget getPaginateBar(){
    return PaginateNumberWidget(
      currentPage: provider!.responsePaginateSubscribePackage?.data!.currentPage!??0,
      pageTotal: provider!.responsePaginateSubscribePackage?.data!.total!??0,
      limitPerPage: AdminConstant.limitItemList,
      progress: provider!.adminPackagesProgressStatus,
      paginateNumberChange: (newPage){
        provider?.subscribeUsersRefreshOrDownloadNextPage(context: context, isResetPage: false);
      },
    );
  }

  //----------------------------------------------------------------- content

  Widget pageContent() {
    // return ;
    return ColumnTemplate.t( children: [
      // headerToolbarAdminPage(),
      table()
    ]);
  }

  //-------------------------------------------------------------------- table

  Widget table() {
    Log.i("table() - listRow - len: " + listRow.length.toString() );
    var tb = TableFastor( listRow : listRow );
    return Container( child:  tb,
    );
  }


}
