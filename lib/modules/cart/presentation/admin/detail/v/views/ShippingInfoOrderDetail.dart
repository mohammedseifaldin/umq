import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/order_detail_admin_page.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';

extension ShippingInfoOrderDetail on OrderDetailAdminState {
  Widget orderDetiailShippingInformation() {
    return ColumnTemplate.t(
        decoration: BoarderHelper.cardView(
          colorLine: DSColor.table_row_title,
        ),
        padding: EdgeInsets.all(DSDimen.space_level_2),
        margin: EdgeInsets.only(
            top: DSDimen.space_level_1,
            left: DSDimen.space_level_2,
            right: DSDimen.space_level_2),
        children: [
          tvTitle(),
          EmptyView.empty(0, DSDimen.space_level_2), //margin

          name(),
          separator(),

          phone(),
          separator(),

          city(),
          separator(),

          addressDetail(),
        ]);
  }

  Widget addressDetail() {
    var title = TextTemplate.t("Address", levelDS: LevelDS.l2);

    String name = widget.mShow.addressDetail ?? "";

    //check not selected
    if (ToolsValidation.isEmpty(name)) {
      name = "Not Selected";
    }

    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  Widget city() {
    var title = TextTemplate.t("City", levelDS: LevelDS.l2);

    var city = widget.mShow.city;
    String name = MCityTools.getNameByLang(context, city);

    //check not selected
    if (ToolsValidation.isEmpty(name)) {
      name = "Not Selected";
    }

    //check not selected
    if (ToolsValidation.isEmpty(name)) {
      name = "Not Selected";
    }

    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  Widget phone() {
    var title = TextTemplate.t("Phone", levelDS: LevelDS.l2);

    String name = widget.mShow.user!.mobile ?? "";
    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(
        // margin: EdgeInsets.only(top: DSDimen.space_level_2 ),
        children: [title, nameTv]);
  }

  Widget name() {
    var title = TextTemplate.t("Name", levelDS: LevelDS.l2);

    String name = widget.mShow.user!.name ?? "";
    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(
        //  margin: EdgeInsets.only(top: DSDimen.space_level_2 ),
        children: [title, nameTv]);
  }

  Widget tvTitle() {
    return TextTemplate.t("Shipping information", levelDS: LevelDS.l1);
  }
}
