


class DynamicLinkFirebaseUtils {

  // handleDynamicLink(Uri url, BuildContext context) {
  //   List<String> separatedString = [];
  //   //separatedString.addAll(url.pathlit('/'));
  // }

  // Future generateDeeplink() async{
  //
  //
  //   try {
  //     String url =  choosePlatformOfLink();
  //
  //     await shareButton( "Scuba App", selectedProduct!.nameEn! , url.characters.string);
  //     print(url);
  //   } catch (e) {
  //     print(e);
  //   }
  //   setState(() {});
  // }

// void initDynamicLinks(BuildContext context) async {
  //   final PendingDynamicLinkData? data =
  //       await FirebaseDynamicLinks.instance.getInitialLink();
  //   final Uri? deepLink = data?.link;
  //
  //   if (deepLink != null) {
  //     handleDynamicLink(deepLink, context);
  //   }
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData? dynamicLink) async {
  //     final Uri? deepLink = dynamicLink?.link;
  //
  //     if (deepLink != null) {
  //       handleDynamicLink(deepLink, context);
  //     }
  //   }, onError: (OnLinkErrorException e) async {
  //     print(e.message);
  //   });
// }


  ///Build a dynamic link firebase
  static Future<String> buildDynamicLink(int id) async {
//     String url = "https://scubaksa.page.link";
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: url,
//       link: Uri.parse('$url/product/$id'),
//       androidParameters: AndroidParameters(
//         packageName: "com.example.scuba",
//         minimumVersion: 0,
//       ),
//
//       socialMetaTagParameters: SocialMetaTagParameters(
//           description: "Nice new product ",
//
//           title: "Product Details"),
//     );
//
// //ANOTHER Way
//     final Uri dynamicUrl = await parameters.buildUrl();
//     return dynamicUrl.toString();
  return "pathDynamic";

  }
}
