class UserModel {
  String name;
  String lastName;
  String email;
  String profilePic;
  String gender;
  String role;

  UserModel(this.name, this.lastName, this.email, this.profilePic, this.gender,
      this.role);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['name'] ?? '',
      map['lastName'] ?? '',
      map['email'] ?? '',
      map['profilePic'] ?? '',
      map['gender'] ?? '',
      map['role'] ?? '',
    );
  }
}
