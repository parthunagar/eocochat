class StripPaymentSecret {
  StripPaymentSecret({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory StripPaymentSecret.fromJson(Map<String, dynamic> json) =>
      StripPaymentSecret(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.clientSecret,
  });

  String clientSecret;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        clientSecret:
            json["clientSecret"] == null ? null : json["clientSecret"],
      );

  Map<String, dynamic> toJson() => {
        "clientSecret": clientSecret == null ? null : clientSecret,
      };
}
