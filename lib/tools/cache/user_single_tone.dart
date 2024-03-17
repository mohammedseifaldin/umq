import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/cache/constant_save.dart';
import 'package:umq/tools/fcm/abdo/general/FCMSubscribe.dart';
import 'package:umq/tools/interfaceGeneral/TypeDefGeneral.dart';
import 'package:umq/tools/values/ToolsValue.dart';

///---------------------------- how to use
///
/// 1- in main()
///
/// void  main()   async  {
///
/// await UserSingleTone.instance();
///
///
///------------------------ class function:
///used to save backend mobile enter untill complete all process of registeration

class UserSingleTone {
  UserSingleTone._();
  //2- make one time sync
  static bool _isSync = false;
  static MUser? _currentUser;
  //3- return instance
  static UserSingleTone instance() {
    if (_isSync == false) {
      _isSync = true;
      _init();
    }
    return UserSingleTone._();
  }

  static void _init() {
    _currentUser = UserSingleTone._().getUser();
  }

  //------------------------------------------------------------------------- setter

  Future saveUserLogin(
      MUser user, String accessToken, CompleteCallBack callback) async {
    Log.i("saveUserLogin() - $user /token: $accessToken");

    //cache data
    await SaveFastor.setInt(ConstantSave.userId, user.id);
    await SaveFastor.setString(ConstantSave.userFirstName, user.name ?? "");
    await SaveFastor.setString(ConstantSave.userEmail, user.email ?? "");
    await SaveFastor.setString(ConstantSave.userFirebaseUId, user.fid ?? "");
    await SaveFastor.setString(ConstantSave.userCountry, user.country ?? "");
    await SaveFastor.setString(ConstantSave.userMobile, user.mobile ?? "");
    await SaveFastor.setInt(ConstantSave.userBlocked, user.block ?? 0);
    await SaveFastor.setInt(ConstantSave.userHidden, user.hidden ?? 0);
    await SaveFastor.setString(ConstantSave.userPhoto, user.photo ?? "");
    await SaveFastor.setString(ConstantSave.userRole, user.role ?? "");
    await SaveFastor.setString(ConstantSave.firstTimeOpenApp,"false");
    await setToken(accessToken);

    //fcm
    await FCMSubscribe.userSpecificPlatform_add();

    //interface
    callback();
  }

  Future setToken(String accessToken) async {
    await SaveFastor.setString(ConstantSave.userToken, accessToken);
  }

  Future setFirebaseUserId(String firebaseUid) async {
    await SaveFastor.setString(ConstantSave.userFirebaseUId, firebaseUid);
  }

  Future setUserId(int id) async {
    await SaveFastor.setInt(ConstantSave.userId, id);
  }

  Future setImageUrl(String url) async {
    await SaveFastor.setString(ConstantSave.userPhoto, url);
  }

  Future setRoleType(String roleName) async {
    /**
        provider
        student
     */
    await SaveFastor.setString(ConstantSave.userRole, roleName);
  }

  Future setLogout() async {
    //fcm
    await FCMSubscribe.userSpecificPlatform_remove();

    await setUserId(0);
    await setToken("");

    //remove value from memory
    /**
     to avoid see the old object from memory, while use click "log out"
     */
    UserSingleTone._currentUser = null;
  }

  //------------------------------------------------------------------------- getter no wait

  MUser? getCurrentUser() {
    return UserSingleTone._currentUser;
  }

  bool isGuestNoWait() {
    return isGuest();
    // if( UserSingleTone._currentUser == null ) return true;
    // var userId = UserSingleTone._currentUser!.id;
    // return ToolsValue.isNotZeroInt( userId );
  }

  bool isAdminOrProviderNoWait() {
    return isRoleAdmin() || isRoleProvider();
    // Log.i( "isAdminOrProvider_noWait() - _currentUser: " + UserSingleTone._currentUser.toString()  );
    // if( UserSingleTone._currentUser == null ) return false;
    // var role = UserSingleTone._currentUser!.role;
    // bool isAdmin =  role  == "admin";
    // bool isProvider =  role  == "provider";
    // return isAdmin || isProvider;
  }

  bool isProviderNoWait() {
    return isRoleProvider();
    // // Log.i( "isAdminOrProvider_noWait() - _currentUser: " + UserSingleTone._currentUser.toString()  );
    // if( UserSingleTone._currentUser == null ) return false;
    // var role = UserSingleTone._currentUser!.role;
    // bool isProvider =  role  == "provider";
    // return isProvider;
  }

  //------------------------------------------------------------------------- getter

  bool isLogin() {
    var userId = SaveFastor.getInt(ConstantSave.userId);
    Log.i("isLogin() - userId: $userId");
    return ToolsValue.isNotZeroInt(userId);
  }

  int getUserId() {
    return SaveFastor.getInt(ConstantSave.userId);
  }

  String getMobile() {
    return SaveFastor.getString(ConstantSave.userMobile);
  }

  String getRole() {
    return SaveFastor.getString(ConstantSave.userRole);
  }

  String getUserName() {
    return SaveFastor.getString(ConstantSave.userFirstName);
  }

  String getFirebaseId() {
    return SaveFastor.getString(ConstantSave.userFirebaseUId);
  }

  String getToken() {
    return SaveFastor.getString(ConstantSave.userToken);
  }

  String getImageUrl() {
    return SaveFastor.getString(ConstantSave.userPhoto);
  }

  MUser getUser() {
    return MUser(
      id: SaveFastor.getInt(ConstantSave.userId),
      name: SaveFastor.getString(ConstantSave.userFirstName),
      email: SaveFastor.getString(ConstantSave.userEmail),
      fid: SaveFastor.getString(ConstantSave.userFirebaseUId),
      country: SaveFastor.getString(ConstantSave.userCountry),
      mobile: SaveFastor.getString(ConstantSave.userMobile),
      role: SaveFastor.getString(ConstantSave.userRole),
      hidden: SaveFastor.getInt(ConstantSave.userHidden),
      block: SaveFastor.getInt(ConstantSave.userBlocked),
      photo: SaveFastor.getString(ConstantSave.userPhoto),
    );
  }

  //----------------------------------------------------------------------- get  role type

  bool isGuest() {
    if (!isLogin()) {
      return true;
    }

    //case no role
    String role = SaveFastor.getString(ConstantSave.userRole);
    if (ToolsValue.isEmpty(role)) {
      return true;
    }

    return false;
  }

  bool isRoleStudent() {
    String role = SaveFastor.getString(ConstantSave.userRole);
    return role == "customer";
  }

  bool isRoleProvider() {
    String role = SaveFastor.getString(ConstantSave.userRole);
    return role == "provider";
  }

  bool isRoleAdmin() {
    String role = SaveFastor.getString(ConstantSave.userRole);
    return role == "admin";
  }
}
