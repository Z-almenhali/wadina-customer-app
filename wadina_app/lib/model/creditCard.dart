class CreditCard {
  String? cardNumber;
  String? cardholdername;
  String? expDate;
  double? amount;

  CreditCard({this.cardNumber, this.cardholdername, this.expDate, this.amount});

  factory CreditCard.fromMap(map) {
    return CreditCard(
      cardNumber: map['cardNumber'],
      cardholdername: map['cardHolderName'],
      expDate: map['expireDate'],
      amount: map['amount'],
    );
  }

//data to server

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'cardHolderName': cardholdername,
      'expireDate': expDate,
      'amount': amount,
    };
  }
}
