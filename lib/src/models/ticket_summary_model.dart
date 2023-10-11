class TicketSummaryModel {
  String? eventId;
  String? name;
  int? price;
  String? ticketType;
  String? location;
  String? image;
  String? currency;
  int? numberOfTickets;

  TicketSummaryModel(
      {this.eventId,
      this.name,
      this.price,
      this.ticketType,
      this.location,
      this.image,
      this.currency,
      this.numberOfTickets});

  factory TicketSummaryModel.fromJson(Map<String, dynamic> json) {
    return TicketSummaryModel(
      eventId: json['eventId'],
      name: json['name'],
      price: json['price'],
      ticketType: json['ticketType'],
      location: json['location'],
      image: json['image'],
      currency: json['currency'],
      numberOfTickets: json['numberOfTickets'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['name'] = name;
    data['price'] = price;
    data['ticketType'] = ticketType;
    data['location'] = location;
    data['image'] = image;
    data['currency'] = currency;
    data['numberOfTickets'] = numberOfTickets;
    return data;
  }

  @override
  String toString() {
    return 'TicketSummaryModel{'
        'eventId: $eventId, '
        'name: $name, '
        'price: $price, '
        'ticketType: $ticketType, '
        'location: $location, '
        'image: $image, '
        'currency: $currency, '
        'numberOfTickets: $numberOfTickets}';
  }
}
