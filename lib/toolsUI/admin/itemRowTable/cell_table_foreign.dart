import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/resource/uiFastor/language/LanguageTools.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';

import 'package:flutter/cupertino.dart';



import 'package:umq/tools/values/ToolsValue.dart';

// ignore: camel_case_types
class cell_table_foreign extends StatefulWidget {
  int? value;
  double width;
  String tableName;
  double? height;

  cell_table_foreign(this.value, this.width, this.tableName, { this.height});

  @override
  cell_table_foreignState createState() {
    return cell_table_foreignState( value, width, tableName );
  }

}



class cell_table_foreignState extends State<cell_table_foreign> {

  static String tag = "cell_table_foreignState";

  int? id;
  double width;
  String tableName;

  //name of this row from another table
  String name = "";

  cell_table_foreignState(this.id, this.width, this.tableName);

  @override
  void initState() {
    super.initState();
    getThisKeyValueName();
  }

  //--------------------------------------------------------------------- build view

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Stack( children: [
      box(),
      txt()
    ],);
  }



  Widget txt() {
    return TextTemplate.t(  name,
      width:  width,
      levelDS: LevelDS.l3,
        padding: EdgeInsets.only(left: 5, top: 5),
    height: AdminDSDimen.row_height_m,
    gravityLayoutAlign: Alignment.topLeft,
        color: DSColor.table_row_title
    );
  }


  Widget box( ) {
    return   Container(
      width : width,
      height: widget.height??AdminDSDimen.row_height_m,
      decoration: BoarderHelper.rounded(
          radiusSize: 0,
          colorBackground: DSColor.table_row_background,
          colorLine: DSColor.table_row_boader
      ),
    );
  }

  //----------------------------------------------------------------------- get name

  void getThisKeyValueName() {
    //check valied
    if( ToolsValue.isEmptyInt( id ) ) {
      finishAPI_setName_notFound();
      return;
    }

    //start api
    startAPIGetName();

  }

  startAPIGetName(){
    try {
      /**
          //import 'package:cloud_firestore/cloud_firestore.dart';
          CollectionReference ref = FirebaseFirestore.instance.collection( tableName);
          //set doc
          ref.doc( id.toString() ).get().then((value) {

          // parse map
          parseMap(value);



          //
          }).catchError((e) {
          // Log.k(tag, "startAPIGetName() - catchError - error: " + e.toString());
          finishAPI_setName_notFound();
          });
       */

    } on Exception catch (e) {
      // Log.k(tag, "startAPIGetName() - exc: " + e.toString());
      finishAPI_setName_notFound();
    }
  }

  void finishAPI_setName(String value ){

    setState(() {
      name = value;
    });
  }

  void finishAPI_setName_notFound(){
    setState(() {
      name = "NA";
    });
  }

  /**
      void parseMap(DocumentSnapshot<Object?> value) {

      String name_en = value["name_en"];
      String name_ar = value["name_ar"];
      // Log.k(tag, "parseMap() - name_en: " + name_en );
      // Log.k(tag, "parseMap() - name_ar: " + name_ar );

      String v = chooseNameByLanguage(name_en, name_ar);

      //check
      if( ToolsValue.isEmpty( v ) ) {return ;}

      //success
      finishAPI_setName( v);
      }
   */


  String  chooseNameByLanguage(String name_en, String name_ar) {
    //choose result
    if( LanguageTools.isArabic( context ) && ToolsValue.isValid( name_ar )) {
      return name_ar;
    } else if ( LanguageTools.isEnglish( context) && ToolsValue.isValid(name_en ) ){
      return name_en;
    } else if ( ToolsValue.isValid( name_en )){
      return name_en;
    } else if ( ToolsValue.isValid( name_ar )){
      return name_ar;
    } else {
      return "";
    }
  }



}

