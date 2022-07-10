class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? country;
  final String? phoneNo;
  final String? dob;
  final String? pin;
  final String? password;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.phoneNo,
    this.dob,
    this.pin,
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
        dob = userData['dob'],
        pin = userData['pin'],
        password = userData['password'];

  User.empty()
      : id = null,
        firstName = null,
        lastName = null,
        email = null,
        country = null,
        phoneNo = null,
        dob = null,
        pin = null,
        password = null;
}
