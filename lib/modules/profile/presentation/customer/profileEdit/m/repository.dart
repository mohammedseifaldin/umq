import 'package:umq/modules/profile/presentation/customer/profileEdit/m/api_provider.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/m/edit_model.dart';
import 'package:umq/tools/data/dynamic/ResponseGeneralDynamic.dart';

class Repository {
  final provider = ApiProvider();

  ///API
  Future<ResponseGeneralDynamic> edit(EditProfileRequest data, int userId) =>
      provider.edit(data, userId);

  // Future<HttpResult> getCountry1() => provider.getCountry();
}
