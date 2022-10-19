class Company {
  String? imageUrl;
  String? Id;
  String? name;
  String? price;
  String? address;
  String? rate;
  String? description;
  String? contract;
  String? phoneNumber;
  String? email;
  bool? registerStatus;

  Company(
      {this.Id,
      this.price,
      this.name,
      this.imageUrl,
      this.address,
      this.rate,
      this.description,
      this.contract,
      this.phoneNumber,
      this.email,this.registerStatus});

  factory Company.fromMap(map) {
    return Company(
      Id: map['CompanyID'],
      address: map['address'],
      contract: map['contract'],
      description: map['description'],
      email: map['email'],
      imageUrl: map['imageURL'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      price: map['price'],
      rate: map['rate'],
      registerStatus: map['registerStatus'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'CompanyID': Id,
      'address': address,
      'contract': contract,
      'description': description,
      'email': email,
      'imageURL': imageUrl,
      'name': name,
      'phoneNumber': phoneNumber,
      'price': price,
      'rate': rate,
      'registerStatus': registerStatus
    };
  }
}
