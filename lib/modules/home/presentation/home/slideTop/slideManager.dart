import 'package:carousel_slider/carousel_slider.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';
import 'package:umq/modules/home/presentation/home/HomePage.dart';
import 'package:umq/modules/home/presentation/home/slideTop/SlideTop.dart';

extension HomeSlider on HomePageState {
//listSlider: responseHomePage.data!.slider!
  Widget getHomeSlider() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),

        sliderView()
        // TextFastor( "Simage")
      ],
    );
  }

  //--------------------------------------------------------------------- slider manager view

  Widget sliderView() {
    return SizedBox(
        width: DeviceTools.getWidth(context),
        height: slideTopFrameHeight,
        // color: Colors.grey.withOpacity( 0.1),
        child: CarouselSlider(
          options: carouselOptions(),
          items: getListSliderWidegt(),
        ));
  }

  CarouselOptions carouselOptions() {
    return CarouselOptions(
        enableInfiniteScroll: false,
        onScrolled: (indexNewSlide) {
          setState(() {
            provider.activeSlider = indexNewSlide!;
          });
        },
        aspectRatio: 16 / 8,
        enlargeCenterPage: true);
  }

  List<Widget> getListSliderWidegt() {
    List<Widget> list = [];
    //check empty
    if (provider.responseHomePage.data == null ||
        provider.responseHomePage.data!.slider == null) {
      return list;
    }
    //loop data
    for (int i = 0; i < provider.responseHomePage.data!.slider!.length; i++) {
      MSlider m = provider.responseHomePage.data!.slider![i];
      list.add(getStackSliderByItem(m));
    }
    return list;
  }
}
