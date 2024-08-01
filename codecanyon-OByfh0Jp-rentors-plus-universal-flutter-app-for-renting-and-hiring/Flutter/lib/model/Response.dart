class Response {
  int status;
  String message;

  Response(this.status, this.message);

  factory Response.fromJson(Map<String, dynamic> json) =>
      Response(json["status"], json["message"]);
}
