import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

class PhoneEgyption {
  //---------------------------------------------------------------------- full phone

  /**
      I/flutter ( 3679): abdo : 04:32:25:470 : getFullPhone() - before edit: 01063499772
      I/flutter ( 3679): abdo : 04:32:25:484 : getFullPhone() - after edit: +201063499772
   */
  static String getFullPhone(String countryCode, String phone) {
    //get
    // String phone = phoneController.value.text.toString();
    // Log.i( "getFullPhone() - before edit - countryCode: " + countryCode  );
    Log.i("getFullPhone() - before edit - phone: $phone");

    //check null or empty countryCode
    if (ToolsValidation.isEmpty(phone)) return "";
    if (ToolsValidation.isEmpty(countryCode)) return phone;

    //trim space
    countryCode = countryCode.trim();
    phone = phone.trim();

    //case : Egypt most of egyption enter phone "+20 01012345678" this is wrong way
    //       the right way to enter "+20 1012345678"
    bool isEgypt = countryCode == "+20";
    if (isEgypt) {
      if (phone.startsWith("01")) {
        phone = phone.replaceFirst("01", "1");
        // phoneController.text = phone;
      }
    }

    //default
    var result = countryCode + phone;
    Log.i("getFullPhone() - after edit: $result");
    return result;
  }
}
