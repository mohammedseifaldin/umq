import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/fastor/ds/DesignSystemFastor.dart';

extension ExtenstionFastorDimen on DesignSystemFastor {

  Future initDimen() async {

    //button
    DSDimen.ds_button_large_corner = 15;
    DSDimen.ds_button_small_corner = 40;

    //corner
    DSDimen.ds_size_corner_level_1 = 15;

    //text size
    DSDimen.text_level_parent = 30; //toolbar text size
    DSDimen.text_level_1 = 18;
    DSDimen.text_level_2 = 15;
    DSDimen.text_level_3 = 13;
    DSDimen.text_level_4 = 7;
  }
}