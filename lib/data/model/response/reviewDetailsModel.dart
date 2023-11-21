
class ReviewDetailsModel {
  Data? data;
  List<String>? message;
  int? status;

  ReviewDetailsModel({
    this.data,
    this.message,
    this.status,
  });

  factory ReviewDetailsModel.fromJson(Map<String, dynamic> json) => ReviewDetailsModel(
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
  num? points;
  Category? category;
  Teacher? teacher;
  num? balance;
  num? totalPoints;
  num? roomRanking;

  Data({
    this.id,
    this.date,
    this.type,
    this.points,
    this.category,
    this.teacher,
    this.balance,
    this.totalPoints,
    this.roomRanking,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    date: json["date"] ,
    type: json["type"],
    points: json["points"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    teacher: json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]),
    balance: json["balance"],
    totalPoints: json["total_points"],
    roomRanking: json["room_ranking"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "type": type,
    "points": points,
    "category": category?.toJson(),
    "teacher": teacher?.toJson(),
    "balance": balance,
    "total_points": totalPoints,
    "room_ranking": roomRanking,
  };
}

class Category {
  int? id;
  String? title;

  Category({
    this.id,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class Teacher {
  int? id;
  String? name;

  Teacher({
    this.id,
    this.name,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
