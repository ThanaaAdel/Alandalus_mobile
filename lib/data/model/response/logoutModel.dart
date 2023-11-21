
class LogoutModel {
  dynamic data;
  List<String>? message;
  int? status;

  LogoutModel({
    this.data,
    this.message,
    this.status,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
      data: json["data"],
      message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
  status: json["status"],
  );

  Map<String, dynamic> toJson() => {
  "data": data,
  "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
  "status": status,
};
}
