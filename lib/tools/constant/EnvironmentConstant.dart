class EnvironmentConstant {

  //--------------------------------- enviorment

  static const isTest = true; //true: means test enviroment
  static const isLive =  !isTest;


  static const isMockAPI = false;  //true: means just loop mock backend not the real backend from api request network
  static const isApiCache = false; //true: means force to get from cache backend

  static const int version = 380;

  static const bool isAutoWriteLoginData = isTest; //true: write login data to easly use

  /**
   this happened when there is no server like hostinger account disabled
   */
  static const bool noServerFound = true;
  //--------------------------------------------------- business logic to seen

  /**
   * true: cause make all pages in english untill version 1
   */
  static const bool business_english_only = true;

  /**
   *
   true: means make walthrought show forever
   */
  static const bool business_walkthrough_forever = false;

  //---------------------------- app info

  static const  String appName = "UMQ" ;

  static String website = "www.umq.app";

  //............................ language

  static const bool isDirectaionLangaugeStatic = false;






  static  String getTranslationsPath(){
    // if( appType_shika_customer ) {
    //   return   'assets/translations';
    // }
    // return   'assets/shika/translations';

    return   'assets/translations';
  }


}