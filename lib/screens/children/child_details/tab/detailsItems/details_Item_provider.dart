
import 'package:alandalos/data/model/response/absenceDetailsModel.dart';
import 'package:alandalos/data/model/response/base/api_response.dart';
import 'package:alandalos/data/model/response/reviewDetailsModel.dart';
import 'package:alandalos/data/repository/detailsRepo.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api_checker.dart';
import '../../../../../data/model/response/examDetailsModel.dart';

class DetailsItemProvider extends ChangeNotifier {
  final DetailsRepo detailsRepo;

  DetailsItemProvider({required this.detailsRepo}) ;



  ReviewDetailsModel? _reviewDetailsModel;
  ExamDetailsModel? _examDetailsModel;
  AbsenceDetailsModel? _absenceDetailsModel;
  bool _isLoading = false;


  ReviewDetailsModel? get reviewDetailsModel => _reviewDetailsModel;
  ExamDetailsModel? get examDetailsModel => _examDetailsModel;
  AbsenceDetailsModel? get absenceDetailsModel => _absenceDetailsModel;
  bool get isLoading => _isLoading;



  Future<ApiResponse> getReviewDetailsList(BuildContext context,String reviewId , studentId) async {
    _isLoading=true;
    ApiResponse apiResponse = await detailsRepo.reviewDetailsRepo(reviewId, studentId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _reviewDetailsModel = ReviewDetailsModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> getExamDetailsList(BuildContext context,String examId , studentId) async {
    _isLoading=true;
    ApiResponse apiResponse = await detailsRepo.examDetailsRepo(examId, studentId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _examDetailsModel = ExamDetailsModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> getAbsenceDetailsList(BuildContext context,String absenceId , studentId) async {
    _isLoading=true;
    ApiResponse apiResponse = await detailsRepo.absenceDetailsRepo(absenceId, studentId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _absenceDetailsModel = AbsenceDetailsModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }

}
