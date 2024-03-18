
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/search/presentation/customer/search_any/search_controller.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/Widgets/loading_widget.dart';
import 'package:umq/toolsUI/itemList/product/ItemProductVertical.dart';

class ProductSearchResultPage extends StatefulWidget {
  final SearchScreenController? _con;
  BuildContext pageContext;

  ProductSearchResultPage(this.pageContext, this._con, {super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ProductSearchResultPage> {
  var scrollcontroller = ScrollController();
  List<MProduct>list=[];
  bool isLoading=false;
  bool isNoMoreRecord=false;

  @override
  void initState() {
    super.initState();
    widget._con!.page=1;
    getInstructorFilter();
    scrollcontroller.addListener(pagination);

  }
  void getInstructorFilter(){
   setState(() {
     isLoading=true;
   });
    widget._con!.apiProductFilter().then((value){

      if(value == null ) return;

      /**
       check at page more than 1, like second page 2 , there is no more data
       */
      bool noMorDataFound = value.data.isEmpty;
      bool notFirstPage = widget._con!.page != 1;
      if(noMorDataFound & notFirstPage) {
        isNoMoreRecord = true ;
       // Tools.ShowErrorMessage(context, "No More Result");
      }

      setState(() {
        isLoading = false;
        list.addAll(value.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: _appBar(),
        backgroundColor: HexColor( ColorProject.blue_fish_front),
        body:Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: _serchResult(),
            controller:scrollcontroller,
          ),
          decoration:const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            color: Colors.white,
          ),
          padding:const EdgeInsets.symmetric(horizontal: 10),
        )
    );
  }
  AppBar _appBar(){
    return AppBar(
      title: Text("Product Search Result",style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: FontProject.mermaid_astramadea,
          fontWeight: FontWeight.bold
      ),),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      centerTitle: true,
      elevation: 0,
        backgroundColor: HexColor( ColorProject.blue_fish_front)
      // backgroundColor: Colors.grey.shade300,
    );
  }
  void pagination() {
    if ((scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent)) {

      /**
       * prevent scrolling again
       */
      if(!isNoMoreRecord) {
        widget._con!.page += 1;
        getInstructorFilter();
      }

    }
  }
  Widget _serchResult(){
    return Column(
      children: [
        ListView.builder(itemBuilder: (context, index) {
          return ItemProductVertical( widget.pageContext,   list[index]);
        }, itemCount: list.length,primary: false,shrinkWrap: true),
        Visibility(child: LoadingWidget(),visible: isLoading,),
        Visibility(child:Container(
          child: Text("No Result Found!"),
          padding: EdgeInsets.all(20),
        ),visible: !isLoading&&list.length==0,),
        tv_no_more_data_found()
      ],
    );
  }



  Widget tv_no_more_data_found() {
    return Visibility(child:Container(
      child: Text("No More Result"),
      padding: EdgeInsets.all(20),
    ),visible: isNoMoreRecord,);
  }

}

