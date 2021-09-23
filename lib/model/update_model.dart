class ShopUpdateModel {
  bool status;
  String message;
  Null date;

  ShopUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    date = json['date'];
  }

}
