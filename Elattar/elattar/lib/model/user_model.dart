class UserModel {
  late String userId, name, phone, nationalId,email, password ;

  UserModel(
    {
      required this.userId,
      required this.name,
      required this.phone,
      required this.nationalId,
      required this.email,
      required this.password
    }
  );

  UserModel.fromJson(Map<String, dynamic> map) {
    // ignore: unnecessary_null_comparison
    if (map == null) {return;}
    userId = map['userId'];
    name = map['name'];
    phone = map['phone'];
    nationalId = map['nationalId'];
    email = map['email'];
    password = map['password'];
  }

  toJson() {
    return {
      'userId':userId,
      'name':name,
      'phone':phone,
      'nationalId':nationalId,
      'email':email,
      'password':password,
    };
  }
}
