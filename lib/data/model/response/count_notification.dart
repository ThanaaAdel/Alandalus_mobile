
class CountNotification {
  Data? data;
  List<String>? message;
  int? status;

  CountNotification({
    this.data,
    this.message,
    this.status,
  });

  factory CountNotification.fromJson(Map<String, dynamic> json) => CountNotification(
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
  num? counter;

  Data({
    this.counter,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    counter: json["counter"],
  );

  Map<String, dynamic> toJson() => {
    "counter": counter,
  };
}
