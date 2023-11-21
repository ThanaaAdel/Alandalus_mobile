
class GraduateModel {
  Data? data;
  List<String>? message;
  int? status;

  GraduateModel({
    this.data,
    this.message,
    this.status,
  });

  factory GraduateModel.fromJson(Map<String, dynamic> json) => GraduateModel(
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
  AcademicReport? academicReport;
  BehavioralReport? behavioralReport;

  Data({
    this.academicReport,
    this.behavioralReport,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    academicReport: json["academic_report"] == null ? null : AcademicReport.fromJson(json["academic_report"]),
    behavioralReport: json["behavioral_report"] == null ? null : BehavioralReport.fromJson(json["behavioral_report"]),
  );

  Map<String, dynamic> toJson() => {
    "academic_report": academicReport?.toJson(),
    "behavioral_report": behavioralReport?.toJson(),
  };
}

class AcademicReport {
  List<Exam>? exams;
  num? appreciationPercentage;
  String? appreciationTitle;

  AcademicReport({
    this.exams,
    this.appreciationPercentage,
    this.appreciationTitle,
  });

  factory AcademicReport.fromJson(Map<String, dynamic> json) => AcademicReport(
      exams: json["exams"] == null ? [] : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),
  appreciationPercentage: json["appreciation_percentage"],
  appreciationTitle: json["\u0024appreciation_title"],
  );

  Map<String, dynamic> toJson() => {
  "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
  "appreciation_percentage": appreciationPercentage,
  "\u0024appreciation_title": appreciationTitle,
};
}

class Exam {
  int? id;
  num? degreeOfExam;
  num? degreeOfStudent;
  Category? category;
  Teacher? teacher;

  Exam({
    this.id,
    this.degreeOfExam,
    this.degreeOfStudent,
    this.category,
    this.teacher,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    degreeOfExam: json["degree_of_exam"],
    degreeOfStudent: json["degree_of_student"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    teacher: json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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

class BehavioralReport {
  num? appreciationPercentage;
  String? appreciationTitle;
  ScrollBehavioralReport? scrollBehavioralReport;

  BehavioralReport({
    this.appreciationPercentage,
    this.appreciationTitle,
    this.scrollBehavioralReport,
  });

  factory BehavioralReport.fromJson(Map<String, dynamic> json) => BehavioralReport(
    appreciationPercentage: json["appreciation_percentage"],
    appreciationTitle: json["appreciation_title"],
    scrollBehavioralReport: json["scroll_behavioral_report"] == null ? null : ScrollBehavioralReport.fromJson(json["scroll_behavioral_report"]),
  );

  Map<String, dynamic> toJson() => {
    "appreciation_percentage": appreciationPercentage,
    "appreciation_title": appreciationTitle,
    "scroll_behavioral_report": scrollBehavioralReport?.toJson(),
  };
}

class ScrollBehavioralReport {
  num? numberOfAbsenceDay;
  num? numberOfDelayDay;
  num? positivePoint;
  num? negativePoint;
  num? totalPoint;

  ScrollBehavioralReport({
    this.numberOfAbsenceDay,
    this.numberOfDelayDay,
    this.positivePoint,
    this.negativePoint,
    this.totalPoint,
  });

  factory ScrollBehavioralReport.fromJson(Map<String, dynamic> json) => ScrollBehavioralReport(
    numberOfAbsenceDay: json["number_of_absence_day"],
    numberOfDelayDay: json["number_of_delay_day"],
    positivePoint: json["positive_point"],
    negativePoint: json["negative_point"],
    totalPoint: json["total_point"],
  );

  Map<String, dynamic> toJson() => {
    "number_of_absence_day": numberOfAbsenceDay,
    "number_of_delay_day": numberOfDelayDay,
    "positive_point": positivePoint,
    "negative_point": negativePoint,
    "total_point": totalPoint,
  };
}
