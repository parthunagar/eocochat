class UserDetail {
  UserDetail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.type,
    this.profilePic,
    this.name,
    this.lastName,
    this.mobile,
    this.countryCode,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.state,
    this.pincode,
    this.city,
    this.lic_image,
    this.is_verified,
    this.national_id_proof,
  });

  String id;
  String userId;
  String type;
  String profilePic;
  String name;
  String lastName;
  String mobile;
  String countryCode;
  String address;
  String createdAt;
  String updatedAt;
  String email;
  String state;
  String pincode;
  String city;
  String lic_image;
  String national_id_proof;
  String is_verified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        profilePic: json["profile_pic"],
        name: json["name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        countryCode: json["country_code"],
        address: json["address"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        email: json["email"],
    state: json["state"],
    pincode: json["pincode"],
    city: json["city"],
    lic_image: json["lic_image"],
    is_verified: json["is_verified"],
    national_id_proof: json["national_id_proof"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "profile_pic": profilePic,
        "name": name,
        "last_name": lastName,
        "mobile": mobile,
        "country_code": countryCode,
        "address": address,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "email": email,
        "state": state,
        "pincode": pincode,
        "city": city,
        "lic_image": lic_image,
        "is_verified": is_verified,
        "national_id_proof": national_id_proof,
      };
}
