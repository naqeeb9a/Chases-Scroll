class EventStats {
  int? totalActiveSales;
  int? totalPendingSales;
  int? totalRefunds;
  int? qtyPendingSold;
  int? qtyActiveSold;
  int? qtyRefunded;
  int? totalNumberOfTickets;
  int? totalNumberOfAvailableTickets;
  List<Tickets>? tickets;
  String? currency;

  EventStats(
      {this.totalActiveSales,
      this.totalPendingSales,
      this.totalRefunds,
      this.qtyPendingSold,
      this.qtyActiveSold,
      this.qtyRefunded,
      this.totalNumberOfTickets,
      this.totalNumberOfAvailableTickets,
      this.tickets,
      this.currency});

  factory EventStats.fromJson(Map<String, dynamic> json) {
    return EventStats(
      totalActiveSales: json['totalActiveSales'],
      totalPendingSales: json['totalPendingSales'],
      totalRefunds: json['totalRefunds'],
      qtyPendingSold: json['qtyPendingSold'],
      qtyActiveSold: json['qtyActiveSold'],
      qtyRefunded: json['qtyRefunded'],
      totalNumberOfTickets: json['totalNumberOfTickets'],
      totalNumberOfAvailableTickets: json['totalNumberOfAvailableTickets'],
      tickets: json['tickets'] != null
          ? List<Tickets>.from(
              json['tickets'].map((v) => Tickets.fromJson(v)),
            )
          : null,
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalActiveSales'] = totalActiveSales;
    data['totalPendingSales'] = totalPendingSales;
    data['totalRefunds'] = totalRefunds;
    data['qtyPendingSold'] = qtyPendingSold;
    data['qtyActiveSold'] = qtyActiveSold;
    data['qtyRefunded'] = qtyRefunded;
    data['totalNumberOfTickets'] = totalNumberOfTickets;
    data['totalNumberOfAvailableTickets'] = totalNumberOfAvailableTickets;
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    data['currency'] = currency;
    return data;
  }

  @override
  String toString() {
    return 'EventStats { '
        'totalActiveSales: $totalActiveSales, '
        'totalPendingSales: $totalPendingSales, '
        'totalRefunds: $totalRefunds, '
        'qtyPendingSold: $qtyPendingSold, '
        'qtyActiveSold: $qtyActiveSold, '
        'qtyRefunded: $qtyRefunded, '
        'totalNumberOfTickets: $totalNumberOfTickets, '
        'totalNumberOfAvailableTickets: $totalNumberOfAvailableTickets, '
        'tickets: $tickets, '
        'currency: $currency }';
  }
}

class Tickets {
  String? ticketType;
  int? totalNumberOfTickets;
  int? totalNumberOfAvailableTickets;
  int? qtyPendingSold;
  int? qtyActiveSold;
  int? qtyRefunded;
  int? totalPendingSales;
  int? totalActiveSales;
  int? totalRefund;

  Tickets(
      {this.ticketType,
      this.totalNumberOfTickets,
      this.totalNumberOfAvailableTickets,
      this.qtyPendingSold,
      this.qtyActiveSold,
      this.qtyRefunded,
      this.totalPendingSales,
      this.totalActiveSales,
      this.totalRefund});

  factory Tickets.fromJson(Map<String, dynamic> json) {
    return Tickets(
      ticketType: json['ticketType'],
      totalNumberOfTickets: json['totalNumberOfTickets'],
      totalNumberOfAvailableTickets: json['totalNumberOfAvailableTickets'],
      qtyPendingSold: json['qtyPendingSold'],
      qtyActiveSold: json['qtyActiveSold'],
      qtyRefunded: json['qtyRefunded'],
      totalPendingSales: json['totalPendingSales'],
      totalActiveSales: json['totalActiveSales'],
      totalRefund: json['totalRefund'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketType'] = ticketType;
    data['totalNumberOfTickets'] = totalNumberOfTickets;
    data['totalNumberOfAvailableTickets'] = totalNumberOfAvailableTickets;
    data['qtyPendingSold'] = qtyPendingSold;
    data['qtyActiveSold'] = qtyActiveSold;
    data['qtyRefunded'] = qtyRefunded;
    data['totalPendingSales'] = totalPendingSales;
    data['totalActiveSales'] = totalActiveSales;
    data['totalRefund'] = totalRefund;
    return data;
  }

  @override
  String toString() {
    return 'Tickets { '
        'ticketType: $ticketType, '
        'totalNumberOfTickets: $totalNumberOfTickets, '
        'totalNumberOfAvailableTickets: $totalNumberOfAvailableTickets, '
        'qtyPendingSold: $qtyPendingSold, '
        'qtyActiveSold: $qtyActiveSold, '
        'qtyRefunded: $qtyRefunded, '
        'totalPendingSales: $totalPendingSales, '
        'totalActiveSales: $totalActiveSales, '
        'totalRefund: $totalRefund }';
  }
}
