import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/c/profile_controller.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/m/ResponseSingleUser.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/v/widgets/information_back_widgets.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/v/widgets/profile_image_view_widget.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/v/widgets/profile_text_view_widget.dart';
import 'package:umq/tools/fcm/abdo/FCMRegister.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/background/BackgroundAllPagesWidget.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';
import 'package:umq/toolsUI/buttons/ButtonLoginGuestView.dart';
import 'package:umq/toolsUI/navigation/m/EnumNavigationPage.dart';
import 'package:umq/toolsUI/navigation/v/NavigationScuba.dart';
import 'package:umq/toolsUI/toolbarBackButton/ToolbarProjectBack.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ResumableState<ProfileScreen> {
  //-------------------------------------------------------------------- variable

  var globalKey = GlobalKey<ScaffoldState>();
  ResponseSingleUser? responseUser;
  var isProvider = false;
  bool isLogin = true;

  XFile? _imageFile;
  // late ProfileController con;
  final ImagePicker _picker = ImagePicker();
  bool photo_progress_status = false;

  // ProfileScreenState() : super(ProfileController()) {
  //   con = controller as ProfileController;
  // }

  //-------------------------------------------------------------------- lifecycle

  @override
  void initState() {
    super.initState();
    Log.i("initState");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await setupFcmFromMainPage(context);
    });
  }

  @override
  void onReady() {
    super.onReady();
    onResume();
  }

  @override
  void onResume() {
    super.onResume();
    Log.i("onResume");

    getProvider();
    getIsLogin();
  }

  //-------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    // return pageContent();
    return PageTemplate.t(this,
        content: pageContent(),

        //fixed background
        widgetBackground:
            BackgroundCardPage(toolbarHeight: ToolbarProjectBack.frameHeight),

        // //toolbar
        // toolbar:   ToolbarProjectBack( "Profile", isHideBackButton: true ,),
        // toolbar_height: ToolbarProjectBack.frameHeight   ,

        //toolbar
        toolbar: ToolbarHomeScuba(context, title: "Profile"),
        toolbar_height: ToolbarHomeScuba.frameHeight,

        //navigation
        navigationBottom:
            NavigationBarButtonsScuba(context, EnumNavigationPage.profile),
        navigationBottom_height: NavigationBarButtonsScuba.frame_height,
        title: "Profile");
  }

  // Widget scaffold(){
  //    return Scaffold(
  //    key: globalKey,
  //    backgroundColor: const Color(0xFFefefef),
  //
  //    body: pageContent(),
  //    );
  // }

  Widget pageContent() {
    return Stack(
      children: [
        EmptyView.allDeviceScreen(context),

        // const AppBarWidget(),
        chooseTypeLoginOrGuest(),
      ],
    );
  }

  Widget chooseTypeLoginOrGuest() {
    //check already trainer
    if (isLogin) {
      return contentTypeLogin();
    } else {
      return contentTypeGuest();
    }
  }

  //------------------------------------------------------------ progress view

  Widget progressView() {
    return Container(
      width: DeviceTools.getWidth(context),
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 100),
      child: CircularProgressIndicator(
        color: DSColor.ds_progress,
      ),
    );
  }

  //------------------------------------------------------------------------- content : guest

  Widget contentTypeGuest() {
    return BackgroundAllPagesWidget(
      child: ColumnTemplate.t(
          children: [bt_login()],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          padding: const EdgeInsets.all(20)),
    );
  }

  Widget bt_login() {
    return ButtonLoginGuestView(context);
  }

  //------------------------------------------------------------------------- content : login

  Widget contentTypeLogin() {
    //check wait to downlaod
    if (responseUser == null || photo_progress_status) {
      return progressView();
    }

    //card info
    return BackgroundAllPagesWidget(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          imageBar(),
          const SizedBox(
            height: 24,
          ),
          informationUser(),
          const SizedBox(
            height: 24,
          ),
          becomeProviderButton()
        ],
      ),
    );
  }

  Widget informationUser() {
    return InformationBackWidget(
      widget: Column(
        children: [
          ProfileTextViewWidget(
            icon: CupertinoIcons.person_circle_fill,
            title: responseUser!.data!.name ?? "NA",
            k: true,
          ),
          ProfileTextViewWidget(
            icon: CupertinoIcons.mail_solid,
            title: responseUser!.data!.email ?? "NA",
            k: true,
          ),
          ProfileTextViewWidget(
            icon: CupertinoIcons.phone_fill,
            title: responseUser!.data!.mobile ?? "NA",
            k: true,
          ),
          ProfileTextViewWidget(
            icon: CupertinoIcons.location_solid,
            title: getNameCity(),
            k: false,
          ),
        ],
      ),
    );
  }

  Widget imageBar() {
    return Row(
      children: [
        networkImage(),
        const SizedBox(
          width: 8,
        ),
        userNameTv(),
        const Spacer(),
        pencilWidget(),
        const SizedBox(
          width: 24,
        ),
      ],
    );
  }

  Widget userNameTv() {
    String name = responseUser!.data!.name ?? "NA";
    return TextTemplate.t(name, levelDS: LevelDS.l1);
  }

  //--------------------------------------------------------------------------

  // Widget imageView() {
  //   return _imageFile != null ? fileImage() : networkImage();
  // }
  //
  // Widget fileImage() {
  //   return FileImageView(
  //     imageFile: _imageFile!,
  //     wait: photo_progress_status,
  //     onTap: () async {
  //       await photo_click();
  //
  //       // photo_progress_status = true;
  //       // final XFile? pickedFile = await _picker.pickImage(
  //       //   source: ImageSource.gallery,
  //       //   maxWidth: 1000,
  //       //   maxHeight: 1000,
  //       //   imageQuality: 100,
  //       // );
  //       // if (pickedFile != null) {
  //       //   _imageFile = pickedFile;
  //       //   setState(() {});
  //       //   await updatePhoto(
  //       //     pickedFile,
  //       //     49,
  //       //   );
  //       // }
  //       // setState(() {
  //       //   photo_progress_status = false;
  //       // });
  //     },
  //   );
  // }

  Widget networkImage() {
    return ProfileImageViewWidget(
      url: responseUser!.data!.photo ?? "",
      wait: photo_progress_status,
      onTap: () async {
        await photoClick();

        // print("Profile Image");
        // photo_progress_status = true;
        // final XFile? pickedFile = await _picker.pickImage(
        //   source: ImageSource.gallery,
        //   maxWidth: 1000,
        //   maxHeight: 1000,
        //   imageQuality: 100,
        // );
        // if (pickedFile != null) {
        //   _imageFile = pickedFile;
        //   setState(() {});
        //   await updatePhoto(
        //     pickedFile,
        //     49,
        //   );
        // }
        // setState(() {
        //   photo_progress_status = false;
        // });
      },
    );
  }

  Widget pencilWidget() {
    return GestureDetector(
      onTap: () {
        GoTo.myAccountProfileEdit(context, this, responseUser!);
      },
      child: Container(
        color: Colors.transparent,
        child: Image.asset(
          "assets/images/pencil.png",
          height: 28,
          width: 28,
        ),
      ),
    );
  }

  Widget becomeProviderButton() {
    //check already trainer
    if (isProvider) {
      return EmptyView.zero();
    }

    return TextTemplate.t("Become a Trainer",
        levelDS: LevelDS.l2,
        padding: const EdgeInsets.all(10),
        textDecoration: TextDecoration.underline, onPressed: () {
      GoTo.becomeTeacher(context);
    });
  }

  String getNameCity() {
    String name = MCityTools.getNameByLang(context, responseUser!.data!.city);
    return name;
  }
}
