import 'package:chases_scroll/src/screens/profile_view/settings/wallet/escrow_view.dart';

class EscrowModel {
  String? id;
  String? orderCode;
  List<String>? boughtTickets;
  List<String>? refundedTickets;
  PayableAmount? payableAmount;
  String? currency;
  String? paymentLink;
  String? orderStatus;
  String? escrowStatus;
  String? paymentMethod;
  String? paystackTxReference;
  String? stripeSessionID;
  String? eventID;
  String? seller;
  String? buyer;
  bool? isDeleted;
  String? timeOfOrder;

  EscrowModel({
    this.id,
    this.orderCode,
    this.boughtTickets,
    this.refundedTickets,
    this.payableAmount,
    this.currency,
    this.paymentLink,
    this.orderStatus,
    this.escrowStatus,
    this.paymentMethod,
    this.paystackTxReference,
    this.stripeSessionID,
    this.eventID,
    this.seller,
    this.buyer,
    this.isDeleted,
    this.timeOfOrder,
  });

  EscrowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['orderCode'];
    boughtTickets = json['boughtTickets'] != null
        ? List<String>.from(json['boughtTickets'])
        : null;
    refundedTickets = json['refundedTickets'] != null
        ? List<String>.from(json['refundedTickets'])
        : null;
    payableAmount = json['payableAmount'] != null
        ? PayableAmount.fromJson(json['payableAmount'])
        : null;
    currency = json['currency'];
    paymentLink = json['paymentLink'];
    orderStatus = json['orderStatus'];
    escrowStatus = json['escrowStatus'];
    paymentMethod = json['paymentMethod'];
    paystackTxReference = json['paystackTxReference'];
    stripeSessionID = json['stripeSessionID'];
    eventID = json['eventID'];
    seller = json['seller'];
    buyer = json['buyer'];
    isDeleted = json['isDeleted'];
    timeOfOrder = json['timeOfOrder'] != null
        ? (json['timeOfOrder'] as List<dynamic>).join('-')
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderCode'] = orderCode;
    data['boughtTickets'] = boughtTickets;
    data['refundedTickets'] = refundedTickets;
    if (payableAmount != null) {
      data['payableAmount'] = payableAmount!.toJson();
    }
    data['currency'] = currency;
    data['paymentLink'] = paymentLink;
    data['orderStatus'] = orderStatus;
    data['escrowStatus'] = escrowStatus;
    data['paymentMethod'] = paymentMethod;
    data['paystackTxReference'] = paystackTxReference;
    data['stripeSessionID'] = stripeSessionID;
    data['eventID'] = eventID;
    data['seller'] = seller;
    data['buyer'] = buyer;
    data['isDeleted'] = isDeleted;
    data['timeOfOrder'] = timeOfOrder;
    return data;
  }

  @override
  String toString() {
    return 'EscrowModel { '
        'id: $id, '
        'orderCode: $orderCode, '
        'boughtTickets: $boughtTickets, '
        'refundedTickets: $refundedTickets, '
        'payableAmount: $payableAmount, '
        'currency: $currency, '
        'paymentLink: $paymentLink, '
        'orderStatus: $orderStatus, '
        'escrowStatus: $escrowStatus, '
        'paymentMethod: $paymentMethod, '
        'paystackTxReference: $paystackTxReference, '
        'stripeSessionID: $stripeSessionID, '
        'eventID: $eventID, '
        'seller: $seller, '
        'buyer: $buyer, '
        'isDeleted: $isDeleted, '
        'timeOfOrder: $timeOfOrder'
        ' }';
  }
}
