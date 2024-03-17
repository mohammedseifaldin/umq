import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/dashboard/presentation/admin/dashboard/v/DashboardPage.dart';
import 'package:umq/modules/dashboard/presentation/admin/dashboard/v/analtyicsCounter/ItemDashboardAnalyticsCounterWidget.dart';
import 'package:umq/modules/place/presentation/admin/city/list/v/CityListAdminPage.dart';

import 'package:umq/modules/cart/presentation/admin/detail/v/OrderDetailAdminPage.dart';
import 'package:umq/modules/cart/presentation/admin/list/v/OrderListAdminPage.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/UserListAdminPage.dart';
import 'package:umq/modules/chat/presentation/UserListPage/v/ChatUserListPage.dart';


extension CounterAnalyticsWidget on DashboardState {

  Widget counterAnalyticsWidget() {
    if( response == null  ) return EmptyView.zero();

    // return ListViewTemplate.t(context: context,
    //     children: getChildrenCounter(),
    //     axis: Axis.vertical );

    if( DeviceTools.isPortrait(context) ) {
      return GridViewFastor(span: 2, children: getChildrenCounter(), axis: Axis.vertical)  ;
    } else {
      return GridViewFastor(span: 5, children: getChildrenCounter(), axis: Axis.vertical );
    }

   }


   List<Widget> getChildrenCounter() {
    List<Widget> list = [];
    list.add( student()   );
    list.add( provider()   );
    list.add( product()   );
    list.add( category()   );
    list.add( galleryImage()   );
    list.add( galleryVideo()   );
    list.add( chatMessage()   );
    list.add( order()   );
    list.add( subscribers() );
    list.add( city()   );
    return list;
   }


   Widget student () {
    return ItemDashboardAnalyticsCounterWidget(title: "student",
        counter: response!.student,
        icon:  Icons.face,
      pageGoTo: UserListAdminPage( ),
    );
   }


  Widget provider() {
    return ItemDashboardAnalyticsCounterWidget(title: "provider",
      counter: response!.provider,
      icon:  Icons.pool,
      pageGoTo: UserListAdminPage( ),
    );
  }


  Widget product() {
    return ItemDashboardAnalyticsCounterWidget(title: "product",
      counter: response!.product,
      icon:  Icons.add_shopping_cart,
      pageGoTo: null,
    );
  }

  Widget category() {
    return ItemDashboardAnalyticsCounterWidget(title: "category",
      counter: response!.productCategory,
      icon:  Icons.category,
      pageGoTo: null,
    );
  }


  Widget galleryImage() {
    return ItemDashboardAnalyticsCounterWidget(title: "image",
      counter: response!.galleryImage,
      icon:  Icons.image,
      pageGoTo: null,
    );
  }


  Widget galleryVideo() {
    return ItemDashboardAnalyticsCounterWidget(title: "video",
      counter: response!.galleryVideo,
      icon:  Icons.video_camera_back,
      pageGoTo: null,
    );
  }


  Widget chatMessage() {
    return ItemDashboardAnalyticsCounterWidget(title: "chat",
      counter: response!.galleryVideo,
      icon:  Icons.chat,
      pageGoTo: ChatUserListPage(),
    );
  }


  Widget order() {
    return ItemDashboardAnalyticsCounterWidget(title: "order",
      counter: response!.order,
      icon:  Icons.card_travel,
      pageGoTo: OrderListAdminPage( ),
    );
  }

  Widget subscribers() {
    return ItemDashboardAnalyticsCounterWidget(title: "subscribers",
      counter: response!.subscribers,
      icon:  Icons.subscriptions,
      pageGoTo:  null ,
    );
  }

  Widget city() {
    return ItemDashboardAnalyticsCounterWidget(title: "city",
      counter: response!.city,
      icon:  Icons.location_city,
      pageGoTo: CityListAdminPage( ),
    );
  }

}