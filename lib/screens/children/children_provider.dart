import 'package:alandalos/core/api_checker.dart';
import 'package:alandalos/data/model/response/base/api_response.dart';
import 'package:alandalos/data/model/response/graduteModel.dart';
import 'package:flutter/material.dart';

import '../../data/model/response/childrenModel.dart';
import '../../data/repository/student_repo.dart';

class StudentsProvider extends ChangeNotifier {
  final StudentRepo studentsRepo;
  StudentsProvider({required this.studentsRepo});


  void refreshData(){
    notifyListeners();
  }

  ChildrenModel? _childrenModel;
  GraduateModel? _graduateModel;
  bool _isLoading = false;

  ChildrenModel? get childrenModel => _childrenModel;
  GraduateModel? get graduateModel => _graduateModel;
  bool get isLoading => _isLoading;

  
  
  Future<ApiResponse> getStudentsList(BuildContext context,String parentId) async {
    _isLoading=true;
    ApiResponse apiResponse = await studentsRepo.studentsRepo(parentId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _childrenModel = ChildrenModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> getGraduateApi(BuildContext context,String studentId,month) async {
    _isLoading=true;
    ApiResponse apiResponse = await studentsRepo.graduateRepo(studentId,month);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _graduateModel = GraduateModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }

}
