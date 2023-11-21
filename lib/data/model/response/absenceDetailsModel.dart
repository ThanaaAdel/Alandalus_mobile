
class AbsenceDetailsModel {
  Data? data;
  List<String>? message;
  int? status;

  AbsenceDetailsModel({
    this.data,
    this.message,
    this.status,
  });

  factory AbsenceDetailsModel.fromJson(Map<String, dynamic> json) => AbsenceDetailsModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
  status: json["status"],
  );

  Map<String, dynamic> toJson() => {
  "data": data?.toJson(),
  "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
  "status": status,
};
}

class Data {
  int? id;
  String? date;
  String? type;
  num? delayDay;
  num? absenceDay;

  Data({
    this.id,
    this.date,
    this.type,
    this.delayDay,
    this.absenceDay,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    date: json["date"],
    type: json["type"],
    delayDay: json["delay_day"],
    absenceDay: json["absence_day"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "type": type,
    "delay_day": delayDay,
    "absence_day": absenceDay,
  };
}
