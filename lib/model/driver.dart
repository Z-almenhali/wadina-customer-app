class Driver {
  String? id;
  String? phoneNumber;
  String? name;
  String? Nationalid;
  String? destination;
  String? email;
  String? neighborhood;
  String? pass;
  String? shift;
  String? companyID;
  String? bussNumber;
  Driver({this.id, this.phoneNumber, this.name,this.Nationalid,this.destination,
  this.email,this.neighborhood,this.pass,this.shift,this.companyID,this.bussNumber});

   factory Driver.fromMap(map) {
    return Driver(
      Nationalid: map['Nationalid/iqama'],
      bussNumber: map['busNumber'],
      companyID: map['companyID'],
      destination: map['destination'],
      email: map['email'],
      id: map['id'],
      name: map['name'],
      neighborhood: map['neighbrhoods'],
      pass: map['password'],
      phoneNumber: map['phoneNumber'],
      shift: map['shift'],
    );
  }
}
