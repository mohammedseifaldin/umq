import 'package:umq/modules/favorite/data/source/FavoriteTeacherApi.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/TeacherDetailsPage.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/toolsUI/snack_bar.dart';

extension ProviderInfoController on ProviderDetailsState {



  Future favProvider(userId, context) async {



    //check login
    if( await UserSingleTone.instance().isGuest() ) {
      CheckoutLoginDialog.show(context);
      return;
    }

    FavoriteTeacherApi().favProvider(userId).then((res) {
      if (res == 200) {
        snackBar(
            context: context, duration: 3, text: 'Provider added to Favorite' );
      }
    });
  }
}