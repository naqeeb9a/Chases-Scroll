import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/models/ticket_summary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventCommFunnelDataProvider =
    StateNotifierProvider<EventCommFunnelModelNotifier, EventCommunityFunnel>(
        (ref) {
  return EventCommFunnelModelNotifier();
});

final ticketSummaryProvider =
    StateNotifierProvider<TicketSummaryModelNotifier, TicketSummaryModel>(
        (ref) {
  return TicketSummaryModelNotifier();
});

class EventCommFunnelModelNotifier extends StateNotifier<EventCommunityFunnel> {
  EventCommFunnelModelNotifier()
      : super(EventCommunityFunnel(
            commName: "", commDesc: "", commImage: "", id: ""));

  void updateCommunityFunnelId({
    String? commName,
    String? commDesc,
    String? commImage,
    String? id,
  }) {
    state = state.copyWith(
      commName: commName,
      commDesc: commDesc,
      commImage: commImage,
      id: id,
    );
  }
}

class TicketSummaryModelNotifier extends StateNotifier<TicketSummaryModel> {
  TicketSummaryModelNotifier()
      : super(TicketSummaryModel(
          eventId: 'Initial EventId',
          name: 'Initial Name',
          price: 0,
          ticketType: 'Initial Ticket Type',
          location: 'Initial Location',
          image: 'Initial Image URL',
          currency: 'Initial Currency',
          time: "initail Time",
          numberOfTickets: 0,
        ));

  void updateTicketSummary(
      {String? eventId,
      String? name,
      double? price,
      String? ticketType,
      String? location,
      String? image,
      String? currency,
      String? time,
      int? numberOfTickets}) {
    state = state.copyWith(
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
}
