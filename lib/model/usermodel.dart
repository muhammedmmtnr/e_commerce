class UserModel {
  String? name;
  String? phone;
  String? address;

  UserModel({
    this.name,
    this.phone,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
      );
}
