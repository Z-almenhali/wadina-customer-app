class Customer {
  String? customerid;
  String? name;
  String? phoneNumber;
  String? email;
  String? schoolName;
  String? latitude;
  String? longitude;
  String? paymentMethod;
  String? neighbrhoods;
  String? pickUpDriver;
  String? dropOfDriver;
  String? companyID;

  Customer(
      {this.customerid,
      this.name,
      this.phoneNumber,
      this.email,
      this.schoolName,
      this.latitude,
      this.longitude,
      this.paymentMethod,
      this.neighbrhoods,
      this.pickUpDriver,
      this.dropOfDriver,
      this.companyID});

//data from server
  factory Customer.fromMap(map) {
    return Customer(
        customerid: map['customerid'],
        name: map['Name'],
        phoneNumber: map['phoneNumber'],
        email: map['email'],
        schoolName: map['schoolName'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        paymentMethod: map['paymentMethod'],
        companyID: map['companyID']);
  }

//data to server

  Map<String, dynamic> toMap() {
    return {
      'customerid': customerid,
      'Name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'schoolName': schoolName,
      'latitude': latitude,
      'longitude': longitude,
      'paymentMethod': paymentMethod
    };
  }

  factory Customer.fromMapForCompany(map) {
    return Customer(
      companyID: map['CompanyID'].trim(),
      name: map['Name'],
      customerid: map['customerid'].trim(),
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      schoolName: map['schoolName'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      paymentMethod: map['paymentMethod'],
      neighbrhoods: map['neighbrhoods'],
      pickUpDriver: map['driverPickup'],
      dropOfDriver: map['driverDropoff'],
    );
  }
}
