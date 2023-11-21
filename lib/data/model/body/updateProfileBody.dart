

class UpdateProfileBody {
  String? name;
  String? password;
  String? email;
  String? parentId;


  UpdateProfileBody({
    this.name,
    this.password,
    this.email,
    this.parentId,

  });

  factory UpdateProfileBody.fromJson(Map<String, dynamic> json) => UpdateProfileBody(
    name: json["name"],
    password: json["password"],
    email: json["email"],
    parentId: json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
    "email": email,
    "parent_id": parentId,
  };
}
