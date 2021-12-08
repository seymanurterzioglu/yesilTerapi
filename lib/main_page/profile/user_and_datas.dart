class Users{
  final String? uid;

  Users({this.uid});
}

class UserData {
  final String? uid;
  String? firstName;
  String? lastName;
  String? age;
  String? height;
  String? weight;
  String? disease;

  UserData({
    this.uid,
    this.firstName,
    this.lastName,
    this.age,
    this.height,
    this.weight,
    this.disease,
  });
}
