import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

class PageViewFastor extends StatefulWidget {
//constructor

  List<Widget> children;
  double frame_widht;
  double frame_height;
  ValueChanged<int>? onChangePage;
  Color indecator_on;
  Color indecator_off;

  PageViewFastor(
      {required List<Widget> this.children,
      required double this.frame_widht,
      required double this.frame_height,
        required Color this.indecator_on,
        required Color this.indecator_off,
      ValueChanged<int>? onChangePage}) {
    this.onChangePage = onChangePage;
  }

  @override
  PageViewFastorState createState() {
    return PageViewFastorState(
        children: children,
        indecator_off: indecator_off,
        indecator_on: indecator_on,
        frame_height: frame_height,
        frame_widht: frame_widht,
        onChangePage: onChangePage);
  }
}

class PageViewFastorState extends State<PageViewFastor> {
  //-------------------------------------------------------------- variable and constructor

  //constructor
  int counterPage = 0;

  List<Widget> children;
  double frame_widht;
  double frame_height;
  ValueChanged<int>? onChangePage;
  Color indecator_on;
  Color indecator_off;

  //controller
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  PageViewFastorState({
    required List<Widget> this.children,
      required double this.frame_widht,
      required double this.frame_height,
    required Color this.indecator_on,
    required Color this.indecator_off,
      ValueChanged<int>? onChangePage}) {
    this.onChangePage = onChangePage;
  }

  //-------------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    initValues();
    return getContent();
  }

  Widget getContent() {
    return ColumnTemplate.t( children: [
      page_adapter(),
      row_indecator()
    ]
    );
  }

  void initValues() {
    counterPage = children.length;
    //Log.i( "initValues() - isArabic: " +  LanguageTools.isArabic( context).toString()) ;
  }

  //------------------------------------------------------------------- page adapter

  Widget page_adapter() {
    var page = PageView(

      /**
       * arabic make reverse
       */
    reverse: LanguageTools.isArabic( context),

      physics: ClampingScrollPhysics(),
      controller: _pageController,
      onPageChanged: (int page) {
       // Log.i("page_adapter() - PageView - onPageChanged: " + page.toString());

        //change state
        setState(() {
          _currentPage = page;
        });

        //call back
        if(onChangePage != null ) {
          onChangePage!( page );
        }
      },

      /**
          test only
          TextTemplate.t("1", color: Colors.blue, width: frame_widht, backgroundColor: Colors.green),
          TextTemplate.t("2", color: Colors.blue, width: frame_widht),
          TextTemplate.t("3", color: Colors.blue, width: frame_widht)
       */
      children: children,
    );

    return Container(child: page, height: frame_height, width: frame_widht,);
  }

  //------------------------------------------------------------------- indecator points

  Widget row_indecator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicator(),
    );
  }

  //--------------------------------------------------------------- indicator by direction

  List<Widget> _buildPageIndicator() {
    if( LanguageTools.isArabic(context) ) {
      return _buildIndicatorArabic();
    } else {
      return _buildIndicatorEnglish();
    }
  }

  List<Widget> _buildIndicatorArabic() {
    List<Widget> list = [];
    int indexEnd = counterPage-1;
    for (int i = indexEnd; i >= 0; i-- ) {
      bool statusActive = i == _currentPage;
      list.add(_indicator(statusActive));
    }
    return list;
  }


  List<Widget> _buildIndicatorEnglish() {
    List<Widget> list = [];
    for (int i = 0; i < counterPage; i++) {
      bool statusActive = i == _currentPage;
      list.add(_indicator(statusActive));
    }
    return list;
  }

  //------------------------------------------------------------------ view of indecator

  Widget _indicator(bool isActive) {

    Color colorChoose =  isActive ? indecator_on : indecator_off;

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
       color: colorChoose,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }


}
