 
import 'package:umq/modules/subscribe/presentation/admin/package_detail/SubscribePackageDetailAdminPage.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

extension EditData on SubscribePackageDetailAdminState {

  Future setEditDataIfFound() async {
    //check no edit needed
    if( widget.mEdit == null ) return;

    request.editObjectId = widget.mEdit!.id;
    request.nameEn = widget.mEdit!.nameEn;
    request.nameAr = widget.mEdit!.nameAr;
    request.descriptionEn = widget.mEdit!.descriptionEn;
    request.descriptionAr = widget.mEdit!.descriptionAr;
    request.price = widget.mEdit!.price;
    request.period = widget.mEdit!.period;
    request.allowedProductNumbers = widget.mEdit!.allowedProductNumers;
    request.allowedChat = ToolsAPI.isSuccess(widget.mEdit!.allowedChat);
  }



}