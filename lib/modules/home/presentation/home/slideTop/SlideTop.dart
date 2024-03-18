import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';
import 'package:umq/modules/home/presentation/home/HomePage.dart';
import 'package:umq/tools/navigate/GoTo.dart';

var slideTopFrameWidth = 300.0;
var slideTopFrameHeight = 0.71 * slideTopFrameWidth; //ratio of height

extension SlideTop on HomePageState {
  //---------------------------------------------------------------------------- calculate size of slider

  void calculateFrameSlide(BuildContext context) {
    if (DeviceTools.isPortrait(context)) {
      slideTopFrameWidth = DeviceTools.get75PercentageWidth(context);
      slideTopFrameHeight = 0.71 * slideTopFrameWidth; //ratio of height
    } else {
      slideTopFrameWidth = DeviceTools.getPercentageHeight(context, 25);
      slideTopFrameHeight = 0.71 * slideTopFrameWidth; //ratio of height
    }
  }

  //---------------------------------------------------------------------------- item slide view

  Widget getStackSliderByItem(MSlider mSlider) {
    var stack = Stack(
      children: [
        imageWidget(mSlider),
        imageIndicator(),
      ],
    );

    var click = GestureDetector(
      child: stack,
      onTap: () {
        String imageUrl = mSlider.image ?? "";
        GoTo.fullScreenImage(context, imageUrl);
      },
    );
    return click;
  }

  Widget imageIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0;
              i < provider.responseHomePage.data!.slider!.length;
              i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 25, right: 5),
              child: CircleAvatar(
                backgroundColor: i == provider.activeSlider.toInt()
                    ? Colors.amber
                    : Colors.white,
                radius: 3,
              ),
            )
        ],
      ),
    );
  }

  Widget imageWidget(MSlider mSlider) {
    return Container(
        alignment: Alignment.center,
        width: DeviceTools.getWidth(context),
        child: _photo(mSlider));
  }

  Widget _photo(MSlider mSlider) {
    /**
        ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
        image: NetworkImage(mSlider.image??"" ),
        placeholder: AssetImage('assets/images/placeholder_slider.png'),
        fit: BoxFit.cover,
        ),
        )
     */

    return ImageViewTemplate(
      context: context,
      widthNeeded: slideTopFrameWidth,
      heightNeeded: slideTopFrameHeight,
      urlBackground: mSlider.image ?? "",
      radius_all: 15,
      assetBackground: AssetImage('assets/images/placeholder_slider.png'),
      onPressed: () {
        String imageUrl = mSlider.image ?? "";
        GoTo.fullScreenImage(context, imageUrl);
      },
    );
  }
}
