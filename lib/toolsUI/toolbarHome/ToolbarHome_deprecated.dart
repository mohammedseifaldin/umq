import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/fastor/drawable/FastorDrawable.dart';

@deprecated
class ToolbarHome_deprecated extends StatefulWidget {
  String myTitle;
  bool hideBackButton = false;
  VoidCallback? onPressed;

  static const frameHeight = 60.0;

  BuildContext contextPage;

  ToolbarHome_deprecated(this.contextPage, this.myTitle,
      {this.onPressed, bool hideBackButton = false}) {
    this.hideBackButton = hideBackButton;

    //  Log.i( "ToolbarSimple - myTitle: $myTitle /onClickListener: $onClickListener");
  }

  @override
  ToolbarHome_deprecatedState createState() {
    return ToolbarHome_deprecatedState(myTitle,
        onPressed: onPressed, hideBackButton: hideBackButton);
  }
}

class ToolbarHome_deprecatedState extends State<ToolbarHome_deprecated> {
  String myTitle;
  bool hideBackButton = false;
  VoidCallback? onPressed;

  ToolbarHome_deprecatedState(this.myTitle,
      {this.onPressed, bool hideBackButton = false}) {
    this.hideBackButton = hideBackButton;
    //  Log.i( "ToolbarSimple - myTitle: $myTitle /onClickListener: $onClickListener");
  }

  //--------------------------------------------------------------------------- build stacks

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Container(
      alignment: Alignment.topCenter,
      child: stackBackButton(),
    );
  }

  Widget stackBackButton() {
    return Stack(
      children: [
        EmptyView.colored(DeviceTools.getWidth(context),
            ToolbarHome_deprecated.frameHeight, DSColor.ds_background_toolbar),
        Align(child: titleWithImage(), alignment: Alignment.topCenter),
        Positioned(child: imageBack(), left: 0)
      ],
    );
  }

  Widget titleWithImage() {
    return Stack(
      children: [
        EmptyView.empty(
            DeviceTools.getWidth(context), ToolbarHome_deprecated.frameHeight),
        Positioned(child: getToolbarBackground(), left: 0, right: 0),
        Positioned(child: title(), left: 0, right: 0),
      ],
    );
  }

  //----------------------------------------------------------------------------- backgorund

  Widget getToolbarBackground() {
    // var marginLeftRight = DSDimen.ds_space_to_level_1 * 2;
    return ImageView(
        width: sizeImageBackgroundResponsive(),
        height: ToolbarHome_deprecated.frameHeight,
        assetAspectRatio: FastorDrawable.toolbar_2,
        responsive_auto: false,
        gravityLayout_alignment: Alignment.topCenter);
  }

  double sizeImageBackgroundResponsive() {
    if (DeviceTools.isPortrait(context)) {
      return DeviceTools.getCostumeWidth(context, 60);
    }
    return 250;
  }

  //---------------------------------------------------------------------------- title

  Widget title() {
    var txt = Text(myTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: DSDimen.text_level_1,
            color: DSColor.toolbar_title,
            decoration: TextDecoration.none));

    return Container(child: txt, margin: EdgeInsets.only(top: 10));
  }

  Widget imageBack() {
    if (hideBackButton) {
      return EmptyView.empty(0, 0);
    }
    //Log.i( "imageBack() " + onClickListener.toString() );

    var image = Image(image: FastorDrawable.toolbar_2, width: 25, height: 19);

    var gesture = GestureDetector(
      onTap: () {
        backClick();
      },
      child: image,
    );

    var containter = Container(
        child: gesture,
        //   color: Colors.red,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: DSDimen.space_level_1, top: 10),
        width: 25 + 5,
        height: 19 + 5);

    return containter;
  }

  void backClick() {
    Log.i("backClick()");
    //check found customer listener
    if (onPressed != null) {
      //   Log.i( "onClickListener needed");
      onPressed!();
      return;
    }

    //finish class
    Navigator.pop(widget.contextPage);
  }
}
