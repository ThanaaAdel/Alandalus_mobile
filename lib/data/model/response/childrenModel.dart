
class ChildrenModel {
  List<ChildrenData>? data;
  List<String>? message;
  int? status;

  ChildrenModel({
    this.data,
    this.message,
    this.status,
  });

  factory ChildrenModel.fromJson(Map<String, dynamic> json) => ChildrenModel(
      data: json["data"] == null ? [] : List<ChildrenData>.from(json["data"]!.map((x) => ChildrenData.fromJson(x))),
  message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
  status: json["status"],
  );

  Map<String, dynamic> toJson() => {
  "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
  "status": status,
};
}

class ChildrenData {
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
  int? newNotificationCount;
  num? schoolRank;
  num? rowRank;
  num? roomRank;

  ChildrenData({
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
    this.newNotificationCount,
    this.schoolRank,
    this.rowRank,
    this.roomRank,
  });

  factory ChildrenData.fromJson(Map<String, dynamic> json) => ChildrenData(
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
    newNotificationCount: json["new_notification_count"],
    schoolRank: json["school_rank"],
    rowRank: json["row_rank"],
    roomRank: json["room_rank"],
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
    "new_notification_count": newNotificationCount,
    "school_rank": schoolRank,
    "row_rank": rowRank,
    "room_rank": roomRank,
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
