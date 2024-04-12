import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/responsive/ResponsiveRectangle.dart';
import 'package:umq/tools/values/ToolsNumber.dart';
import 'package:umq/toolsUI/admin/paginate/c/NumberController.dart';
import 'package:umq/toolsUI/admin/paginate/v/ButtonBarPaginate.dart';
import 'package:umq/toolsUI/admin/paginate/v/TotalInformationBarPaginate.dart';

typedef PaginateCallBack = Function(int page);

class PaginateAdminWidget extends StatefulWidget {
  static double getHeightFrame(BuildContext context) {
    if (DeviceTools.isPortrait(context)) {
      return 145.0; // 200.0;
    }
    return 105.0;
  }

  ValueChanged<PaginateAdminState>? stateListener;
  PaginateCallBack callBackPage;
  int? maxPage;

  PaginateAdminWidget(this.callBackPage,
      {super.key,
      ValueChanged<PaginateAdminState>? stateListener,
      int? maxPage}) {
    if (stateListener != null) {
      this.stateListener = stateListener;
    }

    this.maxPage = maxPage;
  }

  @override
  PaginateAdminState createState() {
    var state = PaginateAdminState(callBackPage, maxPage: maxPage);
    if (stateListener != null) {
      stateListener!(state);
    }
    return state;
  }
}

class PaginateAdminState extends State<PaginateAdminWidget> {
  PaginateCallBack callBack;

  //numbers of page
  List<Widget> listNumberWidget = [];
  int recordTotal = 0; //pages: 100,  the totalBar database record
  int limitPerPage = 0; //pages: 10, limit per every page
  int currentPage = 0; //pages: 1,  Current page selected
  int pageTotal = 0; //pages: 10 , How many page
  int maxPage =
      1000000; //pages: 999, means if there is 1000 page it will show to only page 999

  //go to
  int pageGoTo = 0;
  var tf_goTo;
  late TextEditingController tf_goto_controller;

  PaginateAdminState(this.callBack, {int? maxPage}) {
    //set max
    if (maxPage != null) {
      this.maxPage = maxPage;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupFirstNumber();
    responsiveDrawListNumberWidget();

    tf_goto_controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var bars = ResponsiveToLandscape.portraitVertical_to_landscapeHorizontal(
        context,
        children: [buttonBarPaginate(), totalBarPaginate()]);

    return Container(
        child: bars,
        // alignment: Alignment.center,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: DSDimen.space_level_4));
  }

  //--------------------------------------------------------------------- public methods

  /**
   call when paginate reset again to zero
   */
  void resetPage() {
    setState(() {
      recordTotal = 0;
      limitPerPage = 0;
      currentPage = 0;
      pageTotal = 0;
      tf_goto_controller.text = "";
      setupFirstNumber();
      responsiveDrawListNumberWidget();
    });
  }

  void setPaginateByRecordTotal(
      int totalRecord, int limitPerPage, int currentPage) {
    //set new values
    recordTotal = totalRecord;
    this.limitPerPage = limitPerPage;
    this.currentPage = currentPage;

    //init GoTo
    if (pageGoTo != 0) {
      tf_goto_controller.text = "";
    }

    //calculate pageTotal
    double totalPageDouble = (recordTotal / limitPerPage);

    //round to plus 1 :
    //       * example : recordTotal=28, the value "total" is 2.8
    //                   the result need to be round plus 1 means equal "3"
    pageTotal = ToolsNumber.roundToPlus1(totalPageDouble);

    //case the record totalBar is very little
    // example: page limitPerPage is 10, while the record is 7
    if (recordTotal <= limitPerPage) {
      pageTotal = 1; //first page
    }

    //log
    // Log.i( "setPaginateByRecordTotal() - totalRecord: " + totalRecord.toString()
    //     + " /limitPerPage: " + limitPerPage.toString() + " /currentPage: " + currentPage.toString()  );
    // Log.i( "setPaginateByRecordTotal() - pageTotal: " + pageTotal.toString()
    //     + " /recordTotal: " + recordTotal.toString()  );

    //
    drawListNumberWidget();
  }

  void setMaxPage(int maxPage) {
    this.maxPage = maxPage;
    Log.i("setMaxPage() - maxPage: $maxPage");
  }
}
