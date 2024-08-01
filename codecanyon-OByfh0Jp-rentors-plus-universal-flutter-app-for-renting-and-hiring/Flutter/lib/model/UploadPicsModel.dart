class UploadPicsModel {
  UploadPicsModel({
    this.status,
    this.error,
    this.message,
    this.url,
  });

  String status;
  bool error;
  String message;
  String url;

  factory UploadPicsModel.fromJson(Map<String, dynamic> json) =>
      UploadPicsModel(
        status: json["status"] == null ? null : json["status"],
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "url": url == null ? null : url,
      };
}
