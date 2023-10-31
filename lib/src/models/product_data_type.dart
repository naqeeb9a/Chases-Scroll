class ProductTypeDataa {
  int? totalNumberOfTickets;
  double? ticketPrice;
  String? ticketType;
  int? ticketsSold;
  String? saleID;
  int? minTicketBuy;
  int? maxTicketBuy;

  ProductTypeDataa({
    this.totalNumberOfTickets = 0,
    this.ticketPrice = 0,
    this.ticketType = "Free",
    this.ticketsSold,
    this.saleID,
    this.minTicketBuy = 0,
    this.maxTicketBuy = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalNumberOfTickets': totalNumberOfTickets,
      'ticketPrice': ticketPrice,
      'ticketType': ticketType,
      'ticketsSold': ticketsSold,
      'saleID': saleID,
      'minTicketBuy': minTicketBuy,
      'maxTicketBuy': maxTicketBuy,
    };
  }

  @override
  String toString() {
    return '''
    {
        "totalNumberOfTickets": $totalNumberOfTickets,
        "ticketPrice": $ticketPrice,
        "ticketType": "$ticketType",
        "minTicketBuy": $minTicketBuy,
        "maxTicketBuy": $maxTicketBuy
    }
    ''';
  }
}
