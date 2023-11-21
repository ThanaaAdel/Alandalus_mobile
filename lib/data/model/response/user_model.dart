
class UserModel {
  Data? data;
  List<String>? message;
  int? status;

  UserModel({
    this.data,
    this.message,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
  String? name;
  String? email;
  String? phone;
  List<Student>? students;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.students,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      students: json["students"] == null ? [] : List<Student>.from(json["students"]!.map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
  "id": id,
  "name": name,
  "email": email,
  "phone": phone,
  "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
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
  Room? row;
  Room? room;

  Student({
    this.id,
    this.name,
    this.image,
    this.phone,
    this.positivePoint,
    this.negativePoint,
    this.totalPoint,
    this.numberOfViolations,
    this.row,
    this.room,
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
    row: json["row"] == null ? null : Room.fromJson(json["row"]),
    room: json["room"] == null ? null : Room.fromJson(json["room"]),
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
    "row": row?.toJson(),
    "room": room?.toJson(),
  };
}

class Room {
  int? id;
  String? title;

  Room({
    this.id,
    this.title,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
