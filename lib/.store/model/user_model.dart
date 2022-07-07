class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? country;
  final String? phoneNo;
  final String? dateOfBirth;
  final String? password;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.phoneNo,
    this.dateOfBirth,
    this.password,
  });

  String get fullName => "${firstName ?? ''} ${lastName ?? ''} ";

  @override
  String toString() {
    return "User [name=$firstName $lastName,id=$id,email=$email]";
  }

  User.fromMap(Map<String, dynamic> userData)
      : id = userData['id'],
        firstName = userData['firstName'],
        lastName = userData['lastName'],
        email = userData['email'],
        country = userData['country'],
        phoneNo = userData['phoneNo'],
        dateOfBirth = userData['dateOfBirth'],
        password = userData['password'];

  User.empty()
      : id = null,
        firstName = null,
        lastName = null,
        email = null,
        country = null,
        phoneNo = null,
        dateOfBirth = null,
        password = null;

  static String? _getMoreDetails(dynamic userData, String key) {
    if (userData is Map && userData.containsKey(key)) {
      return userData[key];
    }
    return null;
  }
}
