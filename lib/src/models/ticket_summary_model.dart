class TicketSummaryModel {
  String? eventId;
  String? name;
  double? price;
  String? ticketType;
  String? location;
  String? image;
  String? currency;
  String? time;
  int? numberOfTickets;

  TicketSummaryModel(
      {this.eventId,
      this.name,
      this.price,
      this.ticketType,
      this.location,
      this.image,
      this.currency,
      this.time,
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
      time: json['time'],
      numberOfTickets: json['numberOfTickets'],
    );
  }

  TicketSummaryModel copyWith({
    String? eventId,
    String? name,
    double? price,
    String? ticketType,
    String? location,
    String? image,
    String? currency,
    String? time,
    int? numberOfTickets,
  }) {
    return TicketSummaryModel(
      eventId: eventId,
      name: name,
      price: price,
      ticketType: ticketType,
      location: location,
      image: image,
      currency: currency,
      time: time,
      numberOfTickets: numberOfTickets,
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
    data['time'] = time;
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
        'time: $time, '
        'numberOfTickets: $numberOfTickets}';
  }
}
