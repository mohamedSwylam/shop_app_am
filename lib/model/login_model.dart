class ShopLoginModel {
  bool status;
  String message;
  UserData data;
  ShopLoginModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null ? UserData.fromJson(json['data']):null;
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String images;
  int points;
  int credit;
  String token;

/*  UserData({
    this.id,
    this.name,
    this.phone,
    this.images,
    this.points,
    this.credit,
    this.token,
});*/
  UserData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    images=json['images'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }
}