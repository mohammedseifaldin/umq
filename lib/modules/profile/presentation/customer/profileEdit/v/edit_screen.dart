import 'dart:convert';


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/place/data/response/ResponseListCity.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/c/DownloadCityController.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/c/edit_controller.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/m/repository.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/v/widgets/logoutButtonView.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/v/widgets/title_widget.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/c/profile_controller.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/m/ResponseSingleUser.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/m/edit_model.dart';
import 'package:umq/tools/data/dynamic/ResponseGeneralDynamic.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/m/city_model.dart';

import 'package:umq/toolsUI/toolbarBackButton/ToolbarProjectBack.dart';
import 'package:umq/toolsUI/background/BackgroundAllPagesWidget.dart';
import 'package:umq/toolsUI/dropbox/dropdownCity/CityDropDownWidget.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/v/widgets/edit_button.dart';
import 'package:umq/toolsUI/textField/TextFieldBordered.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

class EditScreen extends StatefulWidget {
  final ResponseSingleUser response;

  const EditScreen({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends StateMVC<EditScreen> {


  // final EditProfileController con = EditProfileController();
   EditProfileController  con = EditProfileController();
   EditProfileState() : super(EditProfileController()) {
     con = controller as EditProfileController;
  }

  String? selectedValue;

  MCity? city; //selected
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Repository repository = Repository();
  ScrollController scrollController = ScrollController();
  // ProfileController profileController = ProfileController();
  bool check = false;

  @override
  void initState() {

    super.initState();
    getDataOfUser();
    getDownloadCity();
    scrollController.addListener(() {});
  }


  getDataOfUser() async {
    nameController.text = widget.response.data!.name??"NA";
    emailController.text = widget.response.data!.email??"NA";
  }

  @override
  Widget build(BuildContext context) {
    Log.i("build() again");

    return Scaffold(
      key: con.globalKey,
      backgroundColor: const Color(0xFFefefef),
      appBar: getAppBarProfileEdit(),
      body: getContent(),
    );
  }

  //---------------------------------------------------------------- toolbar + content page

   PreferredSize getAppBarProfileEdit() {
     return PreferredSize(
       preferredSize: Size.zero,
       child: AppBar(
         /**
             //brightness: Brightness.dark,  deprecated
          */

         systemOverlayStyle: SystemUiOverlayStyle.light,

         backgroundColor: Colors.transparent,
         elevation: 0,
       ),
     );
   }

   Widget getContent() {
    return Stack(
      children: [

        EmptyView.allDeviceScreen(context),

        ToolbarProjectBack( context, "Edit Account" ),
        backgroundCardView()
      ],
    );
   }

  Widget backgroundCardView() {
    return BackgroundAllPagesWidget(
      positionTopMargin: 50,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const TitleWidgetEditProfile(),
          textFieldName(),
          textFieldEmail(),
          dropDown(),
          editButton(),
          bt_logout()
        ],
      ),
    );
  }

  //---------------------------------------------------------------------

  Widget editButton() {

    //city id if found
    /**
     * fix exception:
     * case user not choose city before ,
     *    just user need to change Name and email wihout edit city
     */
    String cityId = ""; //city!.id.toString()
    if( city != null ) {
      cityId = city!.id!.toString();
    }

    return EditButtonWidget(
      check: check,
      onTap: () async {
        check = true;
        EditProfileRequest data = EditProfileRequest(
          name: nameController.text,
          email: emailController.text,
          cityId: cityId,
          photo: widget.response.data!.photo??"",
        );

        //hide keybaord
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }


        await con.editProfile(data, 49);



        // RxBus.post(
        //   "",
        //   tag: "EVENT_CIRCLE_CHANGED",
        // );
        setState(() {});
        Navigator.pop(context);
        check = false;
      },
    );
  }

  Widget dropDown() {
    Log.i("dropDown() build");
    var drop = CityDropDownWidget(
      items: con.listCity,
      selectedValue: selectedValue ?? "Select City",
      onTap: (data, cityName) {
        city = data;
        selectedValue = cityName;
        setState(() {});
      },
    );

    return Container( child:  drop,
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 8)
    );
  }

  Widget textFieldEmail() {
    var tf =  TextFieldBordered(
      controller: emailController,
      hint: "email",
      prefix:   Icon(
        Icons.mail_sharp,
        color: DSColor.ds_textfield_text,
      ),
      type: TextInputType.emailAddress,
    );

    return Container( child:  tf,
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 8)
    );
  }

  Widget textFieldName() {
    var tf =  TextFieldBordered(
      controller: nameController,
      hint: "name",
      prefix:   Icon(
        Icons.person_rounded, //CupertinoIcons.person_circle_fill,
        color: DSColor.ds_textfield_text,
      ),
      type: TextInputType.name,
    );

    return Container( child:  tf,
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 8)
    );
  }

}
