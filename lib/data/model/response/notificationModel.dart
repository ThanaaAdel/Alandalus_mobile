
class NotificationModel {
  List<Datum>? data;
  List<String>? message;
  int? status;

  NotificationModel({
    this.data,
    this.message,
    this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
  String? title;
  String? type;
  String? text;
  String? date;
  int? foreignId;
  Student? student;

  Datum({
    this.id,
    this.title,
    this.type,
    this.text,
    this.date,
    this.foreignId,
    this.student,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    text: json["text"],
    date: json["date"],
    foreignId: json["foreign_id"],
    student: json["student"] == null ? null : Student.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "text": text,
    "date": date,
    "foreign_id": foreignId,
    "student": student?.toJson(),
  };
}

class Student {
  int? id;
  String? name;
  String? image;
  String? phone;
  num? positivePoint;
  num? negativePoint;
  num? totalPoint;
  num? numberOfViolations;

  Student({
    this.id,
    this.name,
    this.image,
    this.phone,
    this.positivePoint,
    this.negativePoint,
    this.totalPoint,
    this.numberOfViolations,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    phone: json["phone"],
    positivePoint: json["positive_point"],
    negativePoint: json["negative_point"],
    totalPoint: json["total_point"],
    numberOfViolations: json["number_of_violations"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "phone": phone,
    "positive_point": positivePoint,
    "negative_point": negativePoint,
    "total_point": totalPoint,
    "number_of_violations": numberOfViolations,
  };
}
