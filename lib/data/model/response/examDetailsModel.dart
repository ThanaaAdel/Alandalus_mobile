
class ExamDetailsModel {
  Data? data;
  List<String>? message;
  int? status;

  ExamDetailsModel({
    this.data,
    this.message,
    this.status,
  });

  factory ExamDetailsModel.fromJson(Map<String, dynamic> json) => ExamDetailsModel(
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
  String? title;
  num? degreeOfExam;
  num? degreeOfStudent;
  Category? category;
  Teacher? teacher;

  Data({
    this.id,
    this.title,
    this.degreeOfExam,
    this.degreeOfStudent,
    this.category,
    this.teacher,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    degreeOfExam: json["degree_of_exam"],
    degreeOfStudent: json["degree_of_student"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    teacher: json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "degree_of_exam": degreeOfExam,
    "degree_of_student": degreeOfStudent,
    "category": category?.toJson(),
    "teacher": teacher?.toJson(),
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
