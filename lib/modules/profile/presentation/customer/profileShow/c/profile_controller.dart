import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/m/api/DownloadShowProfileAPI.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/v/profile_view.dart';
import 'package:umq/tools/attachCapture/attach/AttachTools.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

// class ProfileController extends ControllerMVC {
extension ProfileController on ProfileScreenState {
  //
  // ProfileController();

  getProvider() {
    setState(() {
      isProvider = UserSingleTone.instance().isRoleProvider();
    });
  }

  getIsLogin() {
    setState(() {
      isLogin = UserSingleTone.instance().isLogin();
    });

    if (isLogin) {
      downloadProfileData();
    }
  }

  // updatePhoto(XFile image, int userId) async {
  //   getUp(image);
  // }

  //--------------------------------------------------------------- photo picker

  Future photoClick() async {
    //progress upload
    setState(() {
      photo_progress_status = true;
    });

    /**
     *     CaptureLaravel.typeUploadLaravel( urlApiLink,
     */
    await _listerUploadPhoto();
  }

  Future _listerUploadPhoto() async {
    //upload now
    String urlApiLink = BackendConstant.getUploadFileUrl();
    Map<String, String> body = {};
    body["type"] = "photo_user";

    //attach
    AttachTools.typeImageUploadLaravel(
        urlApiLink, bodyRequest: body, DrawableProject.placeholderImage,
        (status, msg, pathFile, image, uploadedUrl) {
      //progress upload
      setState(() {
        photo_progress_status = false;
      });

      //check value
      if (status == false) {
        ToolsToast.i(context, msg);
        return;
      }
      if (ToolsValidation.isEmpty(uploadedUrl)) {
        return;
      }

      setState(() {
        responseUser!.data!.photo = uploadedUrl;
        // Log.i( "ProfileController - _listerUploadPhoto() - success: " + uploadedUrl );
      });
    });
  }
}
