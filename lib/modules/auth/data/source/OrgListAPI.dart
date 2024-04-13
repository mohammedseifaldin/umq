import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/data/source/ResponseOrgList.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef OrgListCallBack = Function(bool status, String msg , ResponseOrgList response );

class OrgListAPI   {


  int? page ;
  late OrgListCallBack callBack;

  //data
  ResponseOrgList response =  ResponseOrgList();

  Future  getDataPaginate( int  page, OrgListCallBack callBack) async {
    this.page = page;
    this.callBack = callBack;

    await _startAPIGetAll();
  }


  Future  getData(  OrgListCallBack callBack) async {
    this.callBack = callBack;

    await _startAPIGetAll();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPIGetAll() async  {


    String url = "";
    if( page == null ) {
      url = "${BackendConstant.baseUrlv1}/organization/?paginator=10000000&page=1"   ;
    } else {
      url =  "${BackendConstant.baseUrlv1}/organization/?paginator=10&page=$page"   ;
    }


    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken( token );

    NetworkManagerDio().callBack(url, headers:  header,  callback: (status, msg, json){

      if( status ) {
        parseJson(json );
      } else  {
        callBack( false , msg , response );
      }

    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson ) {

    try {

      response = ResponseOrgList().fromJson( mapJson);

      //check
      if ( ToolsAPI.isFailed( response.code) ) {
        callBack( false, "Failed to download", response ) ;
        return;
      }

      //check have data
      if ( response.data == null  ) {
        callBack( false,"Failed to download data"  , response) ;
        return;
      }

      //check have user
      if ( response.data!.data == null  ) {
        callBack( false, "No Data Found" , response) ;
        return;
      }
      // Log.i( "CityListAPI - parseJson() - response: " + response.toString() );
     // Log.i( "CityListAPI - parseJson() - response.length: " + response.data!.data!.length.toString()  );
      //callback
      callBack( true,"Success", response   );

    } catch (e ){
      Log.i( "exe: $e" );
      callBack( false, e.toString(), response ) ;
    }
  }



}