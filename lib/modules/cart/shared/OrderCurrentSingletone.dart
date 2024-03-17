import 'package:umq/modules/cart/data/model/MCartSingleProduct.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/tools/constant/EPaymentMethod.dart';
import 'package:umq/tools/cache/user_single_tone.dart';

class OrderCurrentSingletone {

  //------------------------------------------------------------------- variable



  static var _countryISO = "SA"; //see https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
  static MCity? _city ;
  static var _address = "";
  static List<MCartSingleProduct> _cartList = [];
  // static var _priceProductTotal = "";
  // static var _priceVat = "";
  // static var _priceNet = "";
  static var _paymentMethod = "";

   //user
  static var _userId = 0;
  static var _userName = "";
  static var _userPhone = "";

  //online
  static var _onlinePayment_orderId = "";
  static var _onlinePayment_status = false ;  //true: means payment success

  //------------------------------------------------------------------- singletone

  static bool isSync = false;

  OrderCurrentSingletone._();

  static OrderCurrentSingletone instance() {
    if( isSync == false ) {
      isSync = true;
      //what to do
      OrderCurrentSingletone._().initializeVariable();
    }
    return OrderCurrentSingletone._();
  }

  
  initializeVariable() async {
    _userId = await UserSingleTone.instance().getUserId();
    _userName = await UserSingleTone.instance().getUserName();
    _userPhone = await UserSingleTone.instance().getMobile();
     _countryISO = "SA";
    _city = null ;
    _address = "";
    _cartList = [];
    // _priceProductTotal = "";
    // _priceVat = "";
    // _priceNet = "";
    _paymentMethod = "";
    _onlinePayment_orderId = "";
    _onlinePayment_status = false ;

  }
  
  //------------------------------------------------------------ setter/getter


  get paymentMethod => _paymentMethod;

  set paymentMethod(value) {
    _paymentMethod = value;
  } // see "EPaymentMethod" enum class

  get countryISO => _countryISO;

  set countryISO(value) {
    _countryISO = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get address => _address;

  set address(value) {
    _address = value;
  }

  List<MCartSingleProduct> get cartList => _cartList;

  set cartList(List<MCartSingleProduct> value) {
    _cartList = value;
  }

  // get priceProductTotal => _priceProductTotal;
  //
  // set priceProductTotal(value) {
  //   _priceProductTotal = value;
  // }
  //
  // get priceVat => _priceVat;
  //
  // set priceVat(value) {
  //   _priceVat = value;
  // }
  //
  // get priceNet => _priceNet;
  //
  // set priceNet(value) {
  //   _priceNet = value;
  // }

  get userId => _userId;

  set userId(value) {
    _userId = value;
  }

  get userName => _userName;

  set userName(value) {
    _userName = value;
  }

  get userPhone => _userPhone;

  set userPhone(value) {
    _userPhone = value;
  }

  get onlinePayment_orderId => _onlinePayment_orderId;

  set onlinePayment_orderId(value) {
    _onlinePayment_orderId = value;
  }

  get onlinePayment_status => _onlinePayment_status;

  set onlinePayment_status(value) {
    _onlinePayment_status = value;
  }

  bool isPaymentMethodTypeOnline(){
    bool isOnline = OrderCurrentSingletone.instance().paymentMethod == EPaymentMethod.online.name;
    return isOnline;
  }

}