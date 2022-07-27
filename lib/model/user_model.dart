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
  final String? emailVerified;
  final String? phoneVerified;

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
    this.emailVerified,
    this.phoneVerified,
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
        password = userData['password'],
        emailVerified = userData['emailVerified'],
        phoneVerified = userData['phoneVerified'];

  User.empty()
      : id = null,
        firstName = null,
        lastName = null,
        email = null,
        country = null,
        phoneNo = null,
        dob = null,
        pin = null,
        password = null,
        emailVerified = null,
        phoneVerified = null;
}

class UserProfile {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? country;
  final String? phoneNo;
  final String? dob;
  final String? password;
  final bool? emailVerified;
  final bool? phoneVerified;

  UserProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.phoneNo,
    this.dob,
    this.password,
    this.emailVerified,
    this.phoneVerified,
  });

  UserProfile.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['id'],
        firstName = jsonData['first_name'],
        lastName = jsonData['last_name'],
        email = jsonData['email'],
        country = jsonData['country'],
        phoneNo = jsonData['phone'],
        dob = jsonData['dob'],
        password = jsonData['password'],
        emailVerified = jsonData['email_verified'],
        phoneVerified = jsonData['phone_verified'];
}
