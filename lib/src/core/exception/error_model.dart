class ErrorModel {
  ErrorModel({
    this.message,
  });

  String? message;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"] ??
            json["email"] ??
            json["password"] ??
            'Something went wrong! Please try again later',
      );
}
