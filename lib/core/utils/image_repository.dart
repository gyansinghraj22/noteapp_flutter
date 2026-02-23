// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:get_it/get_it.dart';

// class ImageRepository {
//   CallApi callApi;
//   ImageRepository(this.callApi);

//   Future getImage(image) async {
//     var res = await callApi.postData(
//       ApiUrls.imageUrl,
//       RequestModel({"object_name": "$image"}),
//     );

//     applog(res.data['data']['url']);
//     return res.data['data']['url'];
//   }

//   Future uploadCustomerImg(
//       {required File image, required bool isAuth, String? url}) async {
//     Map<String, dynamic> headers = {};
//     if (isAuth) {
//       String token = SharedPref.getStringValue(KeyString.authTokenKey);
//       headers["Authorization"] = 'bearer $token';
//     }
//     var res;
//     if (url == null) {
//       res = await callApi.postImageMinio(
//           url: isAuth
//               ? ApiUrls.uploadPrivateCustomerImage
//               : ApiUrls.uploadPublicCustomerImage,
//           image: image,
//           isAuth: isAuth,
//           headers: headers);
//     } else {
//       res = await callApi.postImageMinio(
//           url: url, image: image, isAuth: isAuth, headers: headers);
//     }

//     if (res != null) {
//       if (res.statusCode == 200 || res.statusCode == 204) {
//         return res.data["data"];
//       } else {
//         return 'error';
//       }
//     } else {
//       showDynamicErrorToast(
//           'Something went wrong uploading image, try again later');
//     }
//   }

//   Future uploadDocMinio({required dynamic image, required bool isAuth}) async {
//     Map<String, dynamic> headers = {};
//     if (isAuth) {
//       String token = SharedPref.getStringValue(KeyString.authTokenKey);
//       headers["Authorization"] = 'bearer $token';
//     }
//     var res = await callApi.postImageMinio(
//         url: isAuth
//             ? ApiUrls.privateDocumentMinioUrl
//             : ApiUrls.publicDocumentMinioUrl,
//         image: image,
//         isAuth: isAuth,
//         headers: headers);

//     if (res != null) {
//       if (res.statusCode == 200 || res.statusCode == 204) {
//         return res.data["data"];
//       } else {
//         return 'error';
//       }
//     } else {
//       showDynamicErrorToast(
//           'Something went wrong uploading image, try again later');
//     }
//   }

//   Future<Either<dynamic, ErrorModel>> postImageToDB(
//       {required image,
//       required context,
//       required isAuth,
//       required docType,
//       required caption}) async {
//     final kycRepo = GetIt.instance.get<KycRepository>();
//     final loader = GetIt.instance.get<LoadingOverlay>();

//     loader.show(context);

//     var response = await kycRepo.postDocumentForKyc(
//       image: image,
//       isAuth: isAuth,
//       doc_type: docType.toString(),
//       caption: caption.toString(),
//     );

//     return response.fold((l) {
//       loader.hide();
//       showSuccessToast(ResString.imageUploadSucessMessage);
//       return Left(l);
//     }, (r) {
//       loader.hide();
//       showErrorToast(ResString.errorResponse);
//       return Right(
//           ErrorModel(code: r.code, success: false, message: r.message));
//     });
//   }  
// }
