import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umq/toolsUI/Widgets/CircularImage.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';
import 'package:umq/toolsUI/dialog/snack_bar_message.dart';
import 'package:umq/toolsUI/textview/HeaderTextHelper.dart';

class UploadProfilePage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
  const UploadProfilePage({super.key});
}

class _PageState extends State<UploadProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  @override
  void initState() {
    super.initState();
    /*  mBloc.listen((state) {
      if (state is LoadingState) {
        LockOverlay().showClassicLoadingOverlay(context);
      } else {
        LockOverlay().closeOverlay();
        if (state is ProfileUploadState) {
          Tools.ShowSuccessMessage(context, "Profile uploaded successfully");
          Navigator.pushNamed(context, '/homeTest');
        }
        }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_auth.jpeg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                HeaderTextHelper.HeaderText('Upload profile picture',
                    color: Colors.white),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => PicImage(),
                  child: CircularImage(
                      150,
                      image == null
                          ? Image.asset(
                              'assets/images/logo.png',
                              height: 150,
                            )
                          : Image.file(File(image!.path))),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonPrimaryWidget(
                  'Upload',
                  onTap: () {
                    if (image == null) {
                      SnackBarHelper.ShowErrorMessage(
                          context, "Please select image");
                      return;
                    }
                    // mBloc.add(UploadProfileEvent(image!));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void PicImage() async {
    await _picker.pickImage(source: ImageSource.camera).then((value) {
      setState(() {
        image = value;
      });
    });
  }
}
