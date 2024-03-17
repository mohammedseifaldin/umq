
---

---

# General

---

---

## Design Pattern

* Singletone : used in user helper class

----

----

## Architecture 

## First Architecture Used: Clean Architecture 

1. Layer "Data" :
   * Folder "model" : contain Entity Class with methods make processing to this entity.
   * Folder "response" : contain files of json shape to can Serializing
   * Folder "request" : contain files the request file, that will be send as a parameter or raw body
   * Folder "source" : contain the datasource, call network to return response.
   
2. Layer "Provider" :
   * Have logic of pages
   * Used State Management Provider "ChangeNotifier"
   * Every Single Screen extends the ChangeNotifier class. 
   * Example page login extends Authentication class
   ```
   extension LoginNotifier  on  AuthChangeNotifier {
   ```
   
3. layer "Presentation" :
  * contain all ui screens. all widget that have been used
  * every folder "Presentation" contain tow subfolder "admin" and "customer"
  * folder "admin" responsible for ui used in admin panel dashboard
  * folder "customer" responsible for mobile app student
  * in the future if we build "website" we can create third subfolder "website"

## Second Architecture Used: MVC "Model View Controller"

1. Model "M" : 
   a. see folder "lib/modules/{{moduleName}}/data" will found ( model, request, response, source - data source- )
   b. see every single page will found folder name "m" this is symbol of model.

2. Create folder "V" for every page : folder have "View" only without any controller
3. Create folder "C" for every page: folder have "Controller, clickListener, change view, call api"

----

----

## StateManagement

* The Provider ChangeNotifier Used At Many Modules 
* Some Modules use "setState()" to change states

----

----

## Webservice

* use class "Dio" see documentation  [Dio](https://pub.dev/packages/dio)   
* use class "NetworkManagerDio" see documentation [NetworkManagerDio](https://pub.dev/packages/fastor_app_ui_widget#networkmanager)    
* convert json to object: [POJO](https://javiercbk.github.io/json_to_dart/)    

----

----

## CODE STYLE FORMAT

* Clean Code :
   * lines function max 20-25 line….. (example : Widget button Login make in separate method )
   * lines in class max 200 line ….... (example: input fields at signup page in separate class )
  Meaningful Variable Names
* CamelCase : in file name,  
* CamelCase : in Method first character is lower while all method is CamelCase

---

---

# UMQ CODE Documentation

---

---

## EnvironmentConstant class

* to change between developerMode and LiveMode
* In mode developer it will auto write signup and login inputfields
```
  static const isTest = true; //true: means test enviroment
  static const isLive =  !isTest;
  
  static const bool isAutoWriteLoginData = isTest; //true: write login data to easly use
 
```

* Easy to choose page to debug when you enable "EnvironmentConstant.isTest = true".
* Choose page of debug from class named "NextPage.dart" inside method "nextPageTest()".

---

---

## Authentication Application Account

## Admin Account

* phone : +20 1063499771
* otp code: 123456
  (this otp is fixed from firebase console )

## Student Account
* phone : +20 1063499773
* otp code: 123456
  (this otp is fixed from firebase console )

---

---

## Cart Pages

### Process
1. Main Cart Page
2. Shipping detail page
3. Payment Method Page
4. Receipt Page
5. Online Payment Page ( paypal ) in case online payment method
6. Success Order Created

### Class Handle Order In Cart

* class "OrderCurrentSingletone.dart" : save all information about current order creating 
* class "CartUtils.dart" : Helper to calculate the total price of cart item 
* class "MapCurrentOrderToNewOrderRequest.dart" : Map The Data of OrderCurrentSingleTone to class Request API

---

---

## ONLINE PAYPAL PAYMENT

* class Have All IMPORTANT CONSTANT "PayPalConstant.dart" :
  * Edit Environment : Live or Sandbox
  * Write the Client_id and secure_key
  * Edit Currency code : currency = "TWD"; // cheap  "THB"; or "TWD" . in live change to "USD"


----

----

## Color Font & Dimensions

* to setup colors must call from "main()"
```
   //fastor color
   await DesignSystemFastor.ensureInitialized();
```
* class "ExtenstionFastorColor.dart" : handle all colors for your app
``` 
  Future initColor() async {
    _statusBar( );
    _card();
    _progress();
    _toolbar();
    _homeButtonBar();
    _background();
    _text();
    _button();
    _textField_and_spiiner();
    _other();

    //admin panel almost uses
    _table();
    _menu();
  }

```

* class "ExtenstionFastorFont" edit fonts of app
* class "ExtensionFastorDimen" edit all default size.

---

---

## Subscribe To Package

## Request Subscribe By Admin :
* Admin Select One User Id and Selected One Package Id, then click save button

```

class RequestSubscribeUserByAdmin {

/**
required
*/
String? userId;
String? packageId;

/**
just save history in databsae of user information and package information
*/
String? userName;
String? userPhone;
String? packageName;
String? packagePeriod;
String? packageAllowedProductNumers;
String? packageAllowedChat;
String? price;
int byAdmin = 1; //number "1" means yes by admin

```

---

---
 
# UMQ Information

---

---

## Apple And Google Play Important Files

## Android Build APK or Bundle 

* the jks file keystore
```
    signingConfigs {
        release {
            storeFile file("\\umq.jks")
            storePassword "umq.app"
            keyAlias "umq"
            keyPassword "umq.app"
        }
    }
```
the build apk by 
```
flutter build apk --release

or

flutter build appbundle --release
```