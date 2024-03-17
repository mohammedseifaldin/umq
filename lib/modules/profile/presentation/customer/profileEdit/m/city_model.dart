// import 'dart:convert';
//
// CountryModel countryModelFromJson(String str) =>
//     CountryModel.fromJson(json.decode(str));
//
// class CountryModel {
//   CountryModel({
//     required this.status,
//     required this.code,
//     required this.data,
//   });
//
//   String status;
//   int code;
//   Data data;
//
//   factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
//         status: json["status"] ?? "",
//         code: json["code"] ?? 0,
//         data: json["data"] == null
//             ? Data.fromJson({})
//             : Data.fromJson(json["data"]),
//       );
// }
//
// class Data {
//   Data({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.links,
//     required this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     required this.prevPageUrl,
//     required this.to,
//     required this.totalBar,
//   });
//
//   int currentPage;
//   List<Datum> data;
//   String firstPageUrl;
//   int from;
//   int lastPage;
//   String lastPageUrl;
//   List<Link> links;
//   String nextPageUrl;
//   String path;
//   String perPage;
//   String prevPageUrl;
//   int to;
//   int totalBar;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         currentPage: json["current_page"] ?? 0,
//         data: json["data"] == null
//             ? List<Datum>.from(<Datum>[])
//             : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         firstPageUrl: json["first_page_url"] ?? "",
//         from: json["from"] ?? 0,
//         lastPage: json["last_page"] ?? 0,
//         lastPageUrl: json["last_page_url"] ?? "",
//         links: json["links"] == null
//             ? List<Link>.from(<Link>[])
//             : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"] ?? "",
//         path: json["path"] ?? "",
//         perPage: json["per_page"] ?? "",
//         prevPageUrl: json["prev_page_url"] ?? "",
//         to: json["to"] ?? 0,
//         totalBar: json["totalBar"] ?? 0,
//       );
// }
//
// class Datum {
//   Datum({
//     required this.id,
//     required this.nameAr,
//     required this.nameEn,
//     required this.lat,
//     required this.lng,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   int id;
//   String nameAr;
//   String nameEn;
//   String lat;
//   String lng;
//   int status;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"] ?? 0,
//         nameAr: json["name_ar"] ?? "",
//         nameEn: json["name_en"] ?? "",
//         lat: json["lat"] ?? "",
//         lng: json["lng"] ?? "",
//         status: json["status"] ?? 0,
//         createdAt: json["created_at"] == null
//             ? DateTime.now()
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? DateTime.now()
//             : DateTime.parse(json["updated_at"]),
//       );
// }
//
// class Link {
//   Link({
//     required this.url,
//     required this.label,
//     required this.active,
//   });
//
//   String url;
//   String label;
//   bool active;
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"] ?? "",
//         label: json["label"] ?? "",
//         active: json["active"] ?? false,
//       );
// }
