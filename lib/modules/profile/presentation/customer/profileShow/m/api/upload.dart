

// Future<String> getUp(XFile imageFile) async {
//
//   Dio dio = Dio();
//   final mimeTypeData =
//       lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])!.split('/');
//   FormData formData = FormData.fromMap({
//     "file": await MultipartFile.fromFile(imageFile.path,
//         contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
//     "type": "photo_user",
//     "user_id": "50",
//   });
//
//   String token  = await UserSingleTone.instance().getToken();
//
//   var response = await dio.post(
//     BackendConstant.domain + "/public/api/v2/auth/file-upload",
//     data: formData,
//     options: Options(
//       method: 'POST',
//       headers: {
//         HttpHeaders.authorizationHeader:
//             'Bearer $token',
//         'content-Type': 'application/json'
//       },
//     ),
//   );
//
//   print(response.data["message"]);
//   print(response.data["updatePhoto"]);
//   print(response.data["data"]["path"]);
//   RxBus.post(
//     "",
//     tag: "EVENT_CIRCLE_CHANGED",
//   );
//   var message = response.data['message'];
//   return message;
// }
