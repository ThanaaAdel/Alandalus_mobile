import 'dart:io';

import 'package:alandalos/api_service/api_body.dart';
import 'package:alandalos/data/model/response/absenceModel.dart';
import 'package:alandalos/data/model/response/base/api_response.dart';
import 'package:alandalos/data/model/response/examsModel.dart';
import 'package:alandalos/data/model/response/reviewModel.dart';
import 'package:alandalos/utils/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../custom_widgets/custom_dialog.dart';
import '../../../core/api_checker.dart';
import '../../../data/repository/student_repo.dart';

class ChildDetailsProvider extends ChangeNotifier {
  final StudentRepo studentRepo;

  String? profileImage;
  File? imagePath;

  ChildDetailsProvider({required this.studentRepo}) {
    getOfficialInfo();
    getPersonalInfo();
  }



  ReviewsModel? _reviewsModel;
  ExamsModel? _examsModel;
  AbsenceModel? _absenceModel;
  bool _isLoading = false;

  ReviewsModel? get reviewsModel => _reviewsModel;
  ExamsModel? get examsModel => _examsModel;
  AbsenceModel? get absenceModel => _absenceModel;
  bool get isLoading => _isLoading;

  Future<ApiResponse> getReviewList(BuildContext context,String studentId) async {
    _isLoading=true;
    ApiResponse apiResponse = await studentRepo.reviewRepo(studentId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _reviewsModel = ReviewsModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> getExamsList(BuildContext context,String studentId) async {
    _isLoading=true;
    ApiResponse apiResponse = await studentRepo.examsRepo(studentId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _examsModel = ExamsModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> getAbsenceList(BuildContext context,String studentId) async {
    _isLoading=true;
    ApiResponse apiResponse = await studentRepo.absenceRepo(studentId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _absenceModel = AbsenceModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }
  Future<dynamic> pickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera, maxHeight: 300, maxWidth: 300, imageQuality: 90);
            imagePath = File(image!.path);
            updateProfileImage(imagePath);
            notifyListeners();
            if (kDebugMode) {
              print(File(image.path));
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery, maxHeight: 300, maxWidth: 300, imageQuality: 90);
            imagePath = File(imageGallery!.path);
            updateProfileImage(imagePath);
            if (kDebugMode) {
              print(File(imageGallery.path));
            }
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

  void updateProfileImage(File? file) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);

    }
  }

  /// getOfficialInfo API .............
  void getOfficialInfo() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);
  }

/// getPersonalInfo API .............
  void getPersonalInfo() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);


}
