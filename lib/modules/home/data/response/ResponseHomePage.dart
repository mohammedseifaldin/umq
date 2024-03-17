import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';

class ResponseHomePage {
  bool? tokenExpire = false;
  String? status;
  int? code;
  DataHome? data;

  ResponseHomePage({this.status, this.code, this.data});

  ResponseHomePage.fromJson(Map<String, dynamic> json) {
    // Log.i( "ResponseHomePage - fromJson() - json: " + json.toString() );
    tokenExpire = json['token_expire'];
    Log.i("ResponseHomePage - fromJson() - tokenExpire: $tokenExpire");
    status = json['status'];
    code = json['code'];
    // Log.i( "ResponseHomePage - fromJson() - code: " + code.toString() );
    data = json['data'] != null ? DataHome.fromJson(json['data']) : null;
  }
}

class DataHome {
  List<MSlider>? slider;
  ProviderData? teacherData;

  DataHome({this.slider, this.teacherData});

  DataHome.fromJson(Map<String, dynamic> json) {
    //slider
    if (json['slider'] != null) {
      slider = <MSlider>[];
      json['slider'].forEach((v) {
        slider!.add(MSlider.fromJson(v));
      });
    }
    // Log.i( "ResponseHomePage - fromJson() - slider: " + slider.toString() );

    teacherData = json['provider'] != null
        ? ProviderData.fromJson(json['provider'])
        : null;

    // Log.i( "ResponseHomePage - fromJson() - providerData: " + providerData.toString() );
  }
}

class ProviderData {
  List<MProvider>? data;
  int? currentPage;
  int? total;
  int? to;

  ProviderData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    // Log.i( "ProviderData - fromJson() - currentPage: " + currentPage.toString() );

    if (json['data'] != null) {
      data = <MProvider>[];
      json['data'].forEach((v) {
        data!.add(MProvider().fromJson(v));
      });
    }
    // Log.i( "ProviderData - fromJson() - data: " + data.toString() );

    total = json['total'];
    to = json["to"];
  }
}
