import 'package:flutter/foundation.dart';

class DetailsProvider extends ChangeNotifier {
  int id;
  // AppointmentDetailsModel? appointmentDetails;

  DetailsProvider(this.id) {
    getAppointmentDetails(id);
  }

  Future getAppointmentDetails(appointmentId) async {
    if (kDebugMode) {
      print('appointment ID $appointmentId');
    }
    final response =
    //     await ChildrenRepository.getAppointmentDetails(appointmentId);
    // appointmentDetails = response.data;
    notifyListeners();
  }
}