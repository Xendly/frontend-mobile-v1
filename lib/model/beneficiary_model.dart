class Beneficiary {
  final int? id;
  final String? name;
  final String? phoneNo;

  Beneficiary({
    this.id,
    this.name,
    this.phoneNo,
  });

  Beneficiary.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        phoneNo = data['phoneNo'];

  Beneficiary.empty()
      : id = null,
        name = null,
        phoneNo = null;
}
