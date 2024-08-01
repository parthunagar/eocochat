import 'package:equatable/equatable.dart';

class CityModel {
  CityModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<City> data;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<City>.from(json["data"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class City extends Equatable {
  City({
    this.id,
    this.cityName,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.deleted,
  });

  final String id;
  final String cityName;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String deleted;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        cityName: json["city_name"] == null ? null : json["city_name"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        status: json["status"] == null ? null : json["status"],
        deleted: json["deleted"] == null ? null : json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "city_name": cityName == null ? null : cityName,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "status": status == null ? null : status,
        "deleted": deleted == null ? null : deleted,
      };

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
