import 'package:umq/tools/constant/EnvironmentConstant.dart';

class BackendConstant {
  /**
   *  domain three server :
      "https://scuba-ksa.com";
      "http://192.168.1.6/Scuba";
      https://scubaworld.000webhostapp.com/scuba_laravel

      https://umq.app/php/public/api/v1/auth

   */
  static const domain = "https://umq.app/php";

  //append base
  static const baseUrlv1 = "$domain/public/api/v1/auth";
  static const baseUrlv1Fixed = "https://umq.app/api/v1/auth";
  static const baseUrlv2 = "$domain/public/api/v2/auth";
  static const baseUrlv2Public = "$domain/api/v2";
  static const baseUrlv3 = "https://umq.app/api/v3";
  static const uplaods = "https://umq.app/uploads";


  static getUploadFileUrl() {
    if (EnvironmentConstant.noServerFound) {
      return "$domain/public/api/v2/auth/file-upload";
    }
    return "https://umq.app/php/public/api/v2/auth/file-upload";
  }
}
