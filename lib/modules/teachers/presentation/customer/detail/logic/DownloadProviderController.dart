import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/teachers/data/response/ResponseSingleTeacher.dart';
import 'package:umq/modules/teachers/data/source/TeacherDetailAPI.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/TeacherDetailsPage.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';


extension DownloadProviderController on ProviderDetailsState {

  Future startDownloadData() async {

    //check mounted
    /**
     at chat page "the next page" when setState()" callred at chat, th profile
        allso change
     */
    Log.i( "startDownloadData() - mounted $mounted" );
    if( mounted == false ) return;


    //initl
    responseSingleProvider = new ResponseSingleProvider();


    //update prgress
    loadingGallery = true;

    //get id
    int providerIdToDownload = 0;
    if( widget.provider != null ) {
      providerIdToDownload = widget.provider!.id!;
    }else {
      providerIdToDownload = widget.providerId!;
    }


    //listener
    await ProviderDetailAPI().getData( providerIdToDownload, (status, msg, response ) {


      //update prgress
      loadingGallery = false;

      //check failed
      if( status == false ) {
        ToolsToast.i(context, msg);
        return;
      }


      setState(() {
        //now set data
        responseSingleProvider = response;

        widget.provider = response.data!.providerContent!;
      });
    }
    );
  }
}