
class AbsenceModel {
  List<Datum>? data;
  List<String>? message;
  int? status;

  AbsenceModel({
    this.data,
    this.message,
    this.status,
  });

  factory AbsenceModel.fromJson(Map<String, dynamic> json) => AbsenceModel(
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
  status: json["status"],
  );

  Map<String, dynamic> toJson() => {
  "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
  "status": status,
};
}

class Datum {
  int? id;
  String? date;
  String? type;
  num? delayDay;
  num? absenceDay;

  Datum({
    this.id,
    this.date,
    this.type,
    this.delayDay,
    this.absenceDay,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
