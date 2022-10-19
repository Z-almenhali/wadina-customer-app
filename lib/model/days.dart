class Days {
  String? customerid;
  String? pickup;
  String? dropoff;
  String? day;
  bool? active;
  Days({this.day, this.customerid, this.pickup, this.dropoff, this.active});

  factory Days.fromMap(map) {
    return Days(
      day: map['Day'],
      active: map['active'],
      dropoff: map['dropoff'],
      pickup: map['pickup'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickup': pickup,
      'dropoff': dropoff,
      'active': active,
      'Day': day,
    };
  }
}
