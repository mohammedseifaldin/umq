import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/responsive/ResponsiveRectangle.dart';
import 'package:umq/toolsUI/admin/paginate_number/logic/NumberController.dart';
import 'package:umq/toolsUI/admin/paginate_number/widget/ButtonBarPaginate.dart';
import 'package:umq/toolsUI/admin/paginate_number/widget/TotalInformationBarPaginate.dart';

typedef PaginateNumberChange = Function(int page);

class PaginateNumberWidget extends StatefulWidget {
  PaginateNumberChange paginateNumberChange;
  int currentPage; //example pages: 1,  Current page selected
  int pageTotal; //pages: 10 , How many page will be avaliable to download from backend
  int limitPerPage; //example paginator: 10, limit per every page
  int? maxPage;
  bool progress;

  PaginateNumberWidget(
      {super.key,
      required this.currentPage,
      required this.pageTotal,
      required this.limitPerPage,
      required this.progress,
      required this.paginateNumberChange,
      int? maxPage}) {
    this.maxPage ??=
        1000000; //pages: 999, means if there is 1000 page it will show to only page 999 maxPage;
  }

  @override
  PaginateNumberState createState() {
    return PaginateNumberState();
  }

  static double getHeightFrame(BuildContext context) {
    if (DeviceTools.isPortrait(context)) {
      return 145.0; // 200.0;
    }
    return 105.0;
  }
}

class PaginateNumberState extends State<PaginateNumberWidget> {
  //numbers of page
  List<Widget> listNumberWidget = [];
  int recordTotal = 0; //example pages: 100,  the totalBar database record

  //go to by search text
  int pageGoTo = 0;
  late TextEditingController tf_goto_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setupFirstNumber();
      setupScreenChangeSizeDynamically();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: DSDimen.space_level_4),
        child: widget.progress
            ? progressView()
            : barTabButtonAndSearchBarResponsiveBetweenMobileAndDesktop());
  }

  //--------------------------------------------------------------------- progress view

  Widget progressView() {
    var prg = ProgressCircleFastor();

    return Container(
        width: DeviceTools.getWidth(context),
        alignment: Alignment.center,
        color: Colors.white,
        height: PaginateNumberWidget.getHeightFrame(context),
        padding: EdgeInsets.symmetric(vertical: DSDimen.space_level_4),
        child: prg);
  }

  //--------------------------------------------------------------------- tabs view

  Widget barTabButtonAndSearchBarResponsiveBetweenMobileAndDesktop() {
    return ResponsiveToLandscape.portraitVertical_to_landscapeHorizontal(
        context,
        children: [buttonBarPaginate(), totalBarPaginate()]);
  }

  //
  // //--------------------------------------------------------------------- public methods
  //
  // /**
  //  call when paginate reset again to zero
  //  */
  // void resetPage(){
  //   setState(() {
  //     recordTotal = 0;
  //     widget.limitPerPage = 0;
  //     widget.currentPage = 0;
  //     widget.pageTotal = 0;
  //     tf_goto_controller.text = "" ;
  //     setupFirstNumber();
  //     responsiveDrawListNumberWidget();
  //   });
  // }
  //
  // void setPaginateByRecordTotal(int  totalRecord, int limitPerPage, int currentPage ) {
  //
  //
  //   //set new values
  //   this.recordTotal = totalRecord;
  //   this.widget.limitPerPage = limitPerPage;
  //   this.widget.currentPage = currentPage;
  //
  //   //init GoTo
  //   if (pageGoTo != 0 ) {
  //     tf_goto_controller.text = "" ;
  //   }
  //
  //
  //   //calculate pageTotal
  //   double total_page_double  = (recordTotal/limitPerPage) ;
  //
  //   //round to plus 1 :
  //   //       * example : recordTotal=28, the value "total" is 2.8
  //   //                   the result need to be round plus 1 means equal "3"
  //   widget.pageTotal = ToolsNumber.roundToPlus1(total_page_double);
  //
  //   //case the record totalBar is very little
  //   // example: page limitPerPage is 10, while the record is 7
  //   if( recordTotal <= limitPerPage ) {
  //     widget.pageTotal = 1; //first page
  //   }
  //
  //   //log
  //   // Log.i( "setPaginateByRecordTotal() - totalRecord: " + totalRecord.toString()
  //   //     + " /limitPerPage: " + limitPerPage.toString() + " /currentPage: " + currentPage.toString()  );
  //   // Log.i( "setPaginateByRecordTotal() - pageTotal: " + pageTotal.toString()
  //   //     + " /recordTotal: " + recordTotal.toString()  );
  //
  //   //
  //   drawListNumberWidget();
  // }
  //
}
