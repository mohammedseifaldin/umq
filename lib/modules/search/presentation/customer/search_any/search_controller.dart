import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:umq/modules/product/data/model/MCategory.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/product/data/response/ResponsePaginateCategory.dart';
import 'package:umq/modules/place/data/response/city_response.dart';
import 'package:umq/modules/profile/data/response/organization_response.dart';

import 'package:umq/tools/Dios/fresh_dio.dart' as dio;
import 'package:umq/tools/values/ToolsValue.dart';

import '../../../data/response/ResponseSearchProduct.dart';
import '../../../data/response/ResponseSearchProvider.dart';

class SearchScreenController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<MCity> cities = [MCity.constructor(0, "Select City", "Select City")];
  List<MOrganization> Organization = [MOrganization(0, "Select Organization")];
  List<MCategory> category = [MCategory("Select Category", "Select Category")];
  ResponseSearchProvider? search_result;
  MCity? selectedCity;
  MOrganization? selectedOrganization;
  MCategory? selectedCategory;
  int page = 1;
  SearchScreenController() {
    getCity();
    getOrgnaization();
    getCategory();
  }

  void getCity() {
    cityRequest().then((value) {
      cities.addAll(value.data);
      selectedCity = cities.first;
      notifyListeners();
    });
  }

  void getOrgnaization() {
    organizationRequest().then((value) {
      Organization.addAll(value.data);
      selectedOrganization = Organization.first;
      notifyListeners();
    });
  }

  void getCategory() {
    categoryRequest().then((value) {
      category.addAll(value.data!.data!);
      selectedCategory = category.first;
      notifyListeners();
    });
  }

  Future<CityListResponse> cityRequest() async {
    var response = await dio
        .httpClient()
        .get("v2/city", queryParameters: {'page': "1", "paginator": "100"});
    return CityListResponse.fromJson(response.data);
  }

  Future<OrganizationResponse> organizationRequest() async {
    var response = await dio.httpClient().get("v2/organization",
        queryParameters: {'page': "1", "paginator": "100"});
    return OrganizationResponse.fromJson(response.data);
  }

  Future<ResponsePaginateCategory> categoryRequest() async {
    var response = await dio.httpClient().get("v2/category",
        queryParameters: {'page': "1", "paginator": "100", "status": "1"});
    return ResponsePaginateCategory.fromJson(response.data);
  }

  Future<ResponseSearchProvider> ListenerInstructorFilter() async {
    Map map = Map();
    map['status'] = "1";

    if (ToolsValue.isNotZeroInt(selectedCity!.id)) {
      map['city_id'] = "${selectedCity!.id}";
    }

    if (ToolsValue.isNotZeroInt(selectedOrganization!.id)) {
      map['organization_id'] = "${selectedOrganization!.id}";
    }

    if (ToolsValue.isNotZeroInt(selectedCategory!.id)) {
      map['category_id'] = "${selectedCategory!.id}";
    }

    Log.i("SearchController - ListenerInstructorFilter() - body: " +
        map.toString());
    var response = await dio
        .httpClient()
        .post("v2/provider/filter", data: map, queryParameters: {
      "page": page,
    });

    return ResponseSearchProvider().fromJson(response.data);
  }

  Future<ResponseSearchProduct?> apiProductFilter() async {
    Log.i("SearchController - apiProductFilter()  ");

    //body
    Map<String, String> body = Map();
    if (ToolsValue.isNotZeroInt(selectedCategory!.id)) {
      body['category_id'] = "${selectedCategory!.id}";
    }
    body['status'] = "1";

    //url
    String url = BackendConstant.baseUrlv2Public + "/product/filter";
    // var response = await dio.httpClient().post("v2/product/filter",data: map );
    var responseDio = await NetworkManagerDio().post(url, body: body);
    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return ResponseSearchProduct.fromJson(responseDio.data);
    } else {
      return null;
    }
  }
}
