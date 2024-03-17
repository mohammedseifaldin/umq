import 'package:umq/modules/dashboard/data/source/DashboardAdminGetAPI.dart';
import 'package:umq/modules/dashboard/presentation/admin/dashboard/v/DashboardPage.dart';

extension DashboardController on DashboardState {

   startApiGetCounters() async {
     //progress
     setState(() {
       progressStatus = true;
     });

     //network
     DashboardAdminGetAPI().getData((status, msg, response) {
       setState(() {
         progressStatus = false;
         this.response = response;
       });
     });


   }
}