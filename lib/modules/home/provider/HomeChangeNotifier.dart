import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/home/data/model/category_model.dart';
import 'package:umq/modules/home/data/response/ResponseHomePage.dart';

class HomeChangeNotifier extends ChangeNotifier {
  //---------------------------------------------------------------- variable

  //++++++++++++++++++++++++++ page : home

  double activeSlider = 0.0;
  ResponseHomePage responseHomePage = ResponseHomePage();
  List teachers = [];
  List sliders = [];
  bool allDataAdded = false;
  ScrollController homeScrollController = ScrollController();
  bool homeProgress = false;
  List<CategoryModel> categories = [];

  //---------------------------------------------------------------- instance

  static HomeChangeNotifier getListenFalse(BuildContext context) {
    return Provider.of<HomeChangeNotifier>(context, listen: false);
  }

  static HomeChangeNotifier getListenTrue(BuildContext context) {
    return Provider.of<HomeChangeNotifier>(context, listen: true);
  }

  void progressHomeUpdateStatus(BuildContext context, bool newUpdate) {
    homeProgress = newUpdate;
    notifyListeners();
  }
}
