import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/m/edit_model.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/m/repository.dart';
import 'package:umq/tools/data/dynamic/ResponseGeneralDynamic.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class EditProfileController extends ControllerMVC {


  Repository repository = Repository();
  var globalKey = GlobalKey<ScaffoldState>();
  List<MCity> listCity = [];

  EditProfileController();

  editProfile(EditProfileRequest data, int userId) async {
    ResponseGeneralDynamic response = await repository.edit(data, userId);
    if (response.isSuccess) {
      try {


        ToolsToast.i(globalKey.currentState!.context, "Updated Profile");
        // var sMessage = ScaffoldMessenger.of(globalKey.currentState!.context);
        // sMessage.showSnackBar(
        //   const SnackBar(
        //     content: Text(
        //       "Updated",
        //     ),
        //   ),
        // );
        setState(() {});
      } catch (e) {
        // ignore: deprecated_member_use

        var sMessage = ScaffoldMessenger.of(globalKey.currentState!.context);
        sMessage.showSnackBar(
          SnackBar(
            content: Text(
              "Failed $e",
            ),
          ),
        );
      }
    }
  }
}
