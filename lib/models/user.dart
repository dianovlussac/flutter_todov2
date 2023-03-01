class User {
  String? id;
  String? nAME;
  String? contact;
  String? email;
  String? address;
  String? password;

  User(
      {this.id,
      this.nAME,
      this.contact,
      this.email,
      this.address,
      this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nAME = json['NAME'];
    contact = json['contact'];
    email = json['email'];
    address = json['address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['NAME'] = nAME;
    data['contact'] = contact;
    data['email'] = email;
    data['address'] = address;
    data['password'] = password;
    return data;
  }
}
