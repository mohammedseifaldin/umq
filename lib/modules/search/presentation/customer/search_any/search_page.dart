
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/modules/product/data/model/MCategory.dart';
import 'package:umq/modules/product/data/model/MCategoryTools.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';
import 'package:umq/modules/search/presentation/customer/search_any/search_controller.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/ThemeColor.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';
import 'package:umq/toolsUI/dropbox/DrobpoxMobileUtils.dart';

class SearchPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends StateMVC<SearchPage> {
  int pos=0;
  SearchScreenController? provider;
  _PageState() : super(SearchScreenController()) {
    provider = controller as SearchScreenController?;
  }
  @override
  void initState() {
    super.initState();

  }
//------------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(length: 2,
        child: myScaffold()
    );
  }


  Scaffold myScaffold() {
    return Scaffold(
        key: provider!.scaffoldKey,
        appBar: _appBar(),
        backgroundColor: HexColor( ColorProject.blue_fish_front),
        body: getContentOfPage()
    );
  }


  AppBar _appBar(){
    return AppBar(
      title: Text("Search",style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: FontProject.mermaid_astramadea,
          fontWeight: FontWeight.bold
      ),),
      centerTitle: true,
      elevation: 0,
      backgroundColor: HexColor( ColorProject.blue_fish_front),
      // backgroundColor: Colors.grey.shade300, //background color of toolBar
      foregroundColor: Colors.black, //back button colors
      actions: [
        /**
            IconButton(onPressed:(){
            }, icon: Icon(Icons.message,color: Colors.black,size: 30,)),
         */

      ],
    );
  }

  //---------------------------------------------- - Choose Between Provider Or Product

  Widget getContentOfPage(){
    return  Column(
      children: [
        _tabChooseBetweenProviderOrProduct(),

        /**
            choose position visible
         */
        Visibility(child:_instractor_lookingFor(),visible: pos==0,),
        Visibility(child:_product(),visible: pos==1,),
      ],
    );
  }


  /**
   change status of button "Provider" or "Product"
   */
  Widget _tabChooseBetweenProviderOrProduct(){
    return Container(
      child: Row(
        children: [
          Expanded(child: clickOnProvider(), flex: 1,),
          Expanded(child: clickOnProduct(), flex: 1,),
        ],
      ),
      padding:const EdgeInsets.symmetric(horizontal: 1),
    );
  }

  Widget clickOnProvider(){
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        child: Center(
          child: Text('Look for Instructor',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white
          ),),
        ),
        padding:const EdgeInsets.symmetric(vertical: 20),
        decoration: instructor_chooseByLangauge(),
      ),
      onTap: (){
        setState(() {
          pos=0;
        });
      },
    );
  }

  /**
   the english make corner topLeft, while arabic make corner topRight
   */
  BoxDecoration instructor_chooseByLangauge(){
    if( LanguageTools.isArabic(context) ) {
      return BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
          color: pos==0?ThemeColor.hexToColor('#09174b'):ThemeColor.hexToColor('#98dafa')
      );
    } else {
      return BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
          color: pos==0?ThemeColor.hexToColor('#09174b'):ThemeColor.hexToColor('#98dafa')
      );
    }
  }

  Widget clickOnProduct() {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        child: Center(
          child: Text('Look for Product',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color:Colors.white
          ),),
        ),
        padding:const EdgeInsets.symmetric(vertical: 20),
        decoration: product_chooseByLangauge(),
      ),
      onTap: (){
        setState(() {
          pos=1;
        });
      },
    );
  }


  /**
      the english make corner topRight, while arabic make corner topLeft
   */
  BoxDecoration product_chooseByLangauge(){
    if( LanguageTools.isArabic(context) ) {
      return BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
          color: pos==1?ThemeColor.hexToColor('#09174b'):ThemeColor.hexToColor('#98dafa')
      );
    } else {
      return BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
          color: pos==1?ThemeColor.hexToColor('#09174b'):ThemeColor.hexToColor('#98dafa')
      );
    }
  }

  //-------------------------------------------------------------------------- provider

  /**
   * looking for instructor
   */
  Widget _instractor_lookingFor(){
    return Expanded(child: Container(
      alignment: AlignmentDirectional.topStart,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          _lable("Search by city"),
          const SizedBox(height: 10,),
          _city(),
          const SizedBox(height: 10,),
          _lable("Search by organization"),
          const SizedBox(height: 10,),
          _organization(),
          const SizedBox(height: 50,),
          ButtonPrimaryWidget('Search',onTap: (){

            GoTo.resultFilterProvider( context, provider!);
           // Navigator.pushNamed(context, '/search_result',arguments: _con);
          },)
        ],
      ),
    ),flex: 1,);
  }

  //-------------------------------------------------------------------------- product

  Widget _product(){
    return Expanded(child: Container(
      alignment: AlignmentDirectional.topStart,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          _lable("Search by category"),
          const SizedBox(height: 10,),
          _category(),
          const SizedBox(height: 50,),
          ButtonPrimaryWidget('Search',onTap: (){
            GoTo.resultFilterProduct(context, provider! );
          //  Navigator.pushNamed(context, '/product_search_result',arguments: _con);
          },)
        ],
      ),
    ),flex: 1,);
  }

  //-------------------------------------------------------------------------- utils

  Widget _lable(String title){
    return Text(title,style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold
    ),);
  }

  //--------------------------------------------------------------------- provider question

  Widget _city(){
    return Container(
      height: 45,
      padding:const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<MCity>(
            value: provider!.selectedCity,
            isExpanded: true,
            items: provider!.cities.map<DropdownMenuItem<MCity>>((value) {
              return DropdownMenuItem<MCity>(
                  value: value,
                  child: Text(
                    MCityTools.getNameByLang(context, value),
                    style: TextStyle(fontSize: 14,color: ThemeColor.colorSecoundry),
                  ));
            }).toList(),
            dropdownColor: Colors.white,
            iconEnabledColor: ThemeColor.colorSecoundry,
            onChanged: (value) {
              setState(() {
                provider!.selectedCity = value!;
              });
            },
          )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          color: Colors.white.withOpacity(.5),
          border: Border.all(color: ThemeColor.colorSecoundry,width: 1)
      ),
    );
  }


  Widget _organization(){
    return Container(
      height: 45,
      padding:const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<MOrganization>(
            value: provider!.selectedOrganization,
            isExpanded: true,
            items: provider!.Organization.map<DropdownMenuItem<MOrganization>>((value) {
              return DropdownMenuItem<MOrganization>(
                  value: value,
                  child: Text(
                    value.name,
                    style: TextStyle(fontSize: 14,color: ThemeColor.colorSecoundry),
                  ));
            }).toList(),
            dropdownColor: Colors.white,
            iconEnabledColor: ThemeColor.colorSecoundry,
            onChanged: (value) {
              setState(() {
                provider!.selectedOrganization = value!;
              });
            },
          )),
      decoration: DrobpoxMobileUtils.getBoxDecoration()
    );
  }

//--------------------------------------------------------------------- product question

  Widget _category(){
    return Container(
      height: 45,
      padding:const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<MCategory>(
            value: provider!.selectedCategory,
            isExpanded: true,
            items: provider!.category.map<DropdownMenuItem<MCategory>>((value) {
              return DropdownMenuItem<MCategory>(
                  value: value,
                  child: Text(
                    MCategoryTools.getNameByLang( context, value),
                    style: TextStyle(fontSize: 14,color: ThemeColor.colorSecoundry),
                  ));
            }).toList(),
            dropdownColor: Colors.white,
            iconEnabledColor: ThemeColor.colorSecoundry,
            onChanged: (value) {
              setState(() {
                provider!.selectedCategory = value!;
              });
            },
          )),
        decoration: DrobpoxMobileUtils.getBoxDecoration()
    );
  }



}
