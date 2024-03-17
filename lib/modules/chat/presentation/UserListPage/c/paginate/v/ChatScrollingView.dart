
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/c/ChatScrollController.dart';


import '../ChatScrollManager.dart';

extension ChatScrollingController on ChatScrollState {

  Widget getBuildView( ) {
    return getChildrenColumn();
  }

  Widget getChildrenColumn(){
    //add children of itemlist
    List<Widget> editList = [];
    for( int i = 0 ; i < widget.children.length ; i++ ) {
      Widget w = widget.children[i];
      editList.add( w );
    }

    //add load more
    editList.add( tv_loadMore() );

    //view
    return Column( children: editList );
  }


  Widget progressAtBottomScreen() {
    //check not progress loading now
    if(loading == false ) {
      return EmptyView.zero();
    }

    //check show at page more than 1
    if( pageFuture < 2 ) {
      return EmptyView.zero();
    }
    return ProgressSpinkit.get();
  }

  /**
      show at center of page when is page number is "1"
      because at this time there is no data shown to user
      not need to show the bottom progress
   */
  Widget progressAtCenterScreen() {

    //check not progress loading now
    if(loading == false ) {
      return EmptyView.zero();
    }

    //check show at page 1 only
    if( pageFuture != 1 ) {
      return EmptyView.zero();
    }

    return ProgressSpinkit.centerPage(context);
  }

  BoxDecoration mainContainerDecoration(){
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(35))
    );
  }

  Widget tv_loadMore(){
    //check not completed or not start yet
    if( isCompleteAllPages ||
        pageFuture == 0
    ) {
      return EmptyView.zero();
    }


    //view
    return TextTemplate.t( "Load More" ,
    padding: const EdgeInsets.all(5),
    levelDS: LevelDS.l3,
    width: DeviceTools.getWidth(context),
    textAlign: TextAlign.center,
    onPressed: (){
      whatToDoScrollDown();
    });
  }
}